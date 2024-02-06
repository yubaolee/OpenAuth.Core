﻿using System;
using System.Linq;
using Infrastructure;
using Microsoft.EntityFrameworkCore;
using OpenAuth.App.Interface;
using OpenAuth.Repository.Core;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    public abstract class BaseApp<T, TDbContext> where T : class where TDbContext: DbContext
    {
        /// <summary>
        /// 用于普通的数据库操作
        /// </summary>
        protected IRepository<T, TDbContext> Repository;

        /// <summary>
        /// 用于事务操作
        /// <para>使用详见：http://doc.openauth.net.cn/core/unitwork.html</para>
        /// </summary>
        protected IUnitWork<TDbContext> UnitWork;

        protected IAuth _auth;

        public BaseApp(IUnitWork<TDbContext> unitWork, IRepository<T,TDbContext> repository, IAuth auth)
        {
            UnitWork = unitWork;
            Repository = repository;
            _auth = auth;
        }

        /// <summary>
        ///  获取当前登录用户的数据访问权限
        /// </summary>
        /// <param name="parametername">linq表达式参数的名称，如u=>u.name中的"u"</param>
        /// <returns></returns>
        protected IQueryable<T> GetDataPrivilege(string parametername)
        {
            var loginUser = _auth.GetCurrentUser();
            if (loginUser.User.Account == Define.SYSTEM_USERNAME) return UnitWork.Find<T>(null);  //超级管理员特权
            
            var moduleName = typeof(T).Name;
            var rule = UnitWork.FirstOrDefault<DataPrivilegeRule>(u => u.SourceCode == moduleName);
            if (rule == null) return UnitWork.Find<T>(null); //没有设置数据规则，那么视为该资源允许被任何主体查看
            if (rule.PrivilegeRules.Contains(Define.DATAPRIVILEGE_LOGINUSER) ||
                                             rule.PrivilegeRules.Contains(Define.DATAPRIVILEGE_LOGINROLE)||
                                             rule.PrivilegeRules.Contains(Define.DATAPRIVILEGE_LOGINORG))
            {
                
                //即把{loginUser} =='xxxxxxx'换为 loginUser.User.Id =='xxxxxxx'，从而把当前登录的用户名与当时设计规则时选定的用户id对比
                rule.PrivilegeRules = rule.PrivilegeRules.Replace(Define.DATAPRIVILEGE_LOGINUSER, loginUser.User.Id);
                
                var roles = loginUser.Roles.Select(u => u.Id).ToList();
                roles.Sort(); //按字母排序,这样可以进行like操作
                rule.PrivilegeRules = rule.PrivilegeRules.Replace(Define.DATAPRIVILEGE_LOGINROLE, 
                    string.Join(',',roles));
                
                var orgs = loginUser.Orgs.Select(u => u.Id).ToList();
                orgs.Sort(); 
                rule.PrivilegeRules = rule.PrivilegeRules.Replace(Define.DATAPRIVILEGE_LOGINORG, 
                    string.Join(',',orgs));
            }
            return UnitWork.Find<T>(null).GenerateFilter(parametername,
                JsonHelper.Instance.Deserialize<FilterGroup>(rule.PrivilegeRules));
        }
        
        /// <summary>
        /// 计算实体更新的层级信息
        /// </summary>
        /// <typeparam name="U">U必须是一个继承TreeEntity的结构</typeparam>
        /// <param name="entity"></param>
        public void CaculateCascade<U>(U entity) where U : TreeEntity
        {
            if (entity.ParentId == "") entity.ParentId = null;
            string cascadeId;
            int currentCascadeId = 1; //当前结点的级联节点最后一位
            var sameLevels = UnitWork.Find<U>(o => o.ParentId == entity.ParentId && o.Id != entity.Id);
            foreach (var obj in sameLevels)
            {
                int objCascadeId = int.Parse(obj.CascadeId.TrimEnd('.').Split('.').Last());
                if (currentCascadeId <= objCascadeId) currentCascadeId = objCascadeId + 1;
            }

            if (!string.IsNullOrEmpty(entity.ParentId))
            {
                var parentOrg = UnitWork.FirstOrDefault<U>(o => o.Id == entity.ParentId);
                if (parentOrg != null)
                {
                    cascadeId = parentOrg.CascadeId + currentCascadeId + ".";
                    entity.ParentName = parentOrg.Name;
                }
                else
                {
                    throw new Exception("未能找到该组织的父节点信息");
                }
            }
            else
            {
                cascadeId = ".0." + currentCascadeId + ".";
                entity.ParentName = "根节点";
            }

            entity.CascadeId = cascadeId;
        }
    }
}