﻿using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    public class OrgManagerApp : BaseTreeApp<SysOrg,OpenAuthDBContext>
    {
        private RevelanceManagerApp _revelanceApp;
        /// <summary>
        /// 添加部门
        /// </summary>
        /// <param name="sysOrg">The org.</param>
        /// <returns>System.Int32.</returns>
        /// <exception cref="System.Exception">未能找到该组织的父节点信息</exception>
        public string Add(SysOrg sysOrg)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }
            CaculateCascade(sysOrg);

            UnitWork.ExecuteWithTransaction(() =>
            {
                UnitWork.Add(sysOrg);
                UnitWork.Save();

                //如果当前账号不是SYSTEM，则直接分配
                if (loginContext.User.Account != Define.SYSTEM_USERNAME)
                {
                    _revelanceApp.Assign(new AssignReq
                    {
                        type = Define.USERORG,
                        firstId = loginContext.User.Id,
                        secIds = new[] { sysOrg.Id }
                    });
                }
            });

            return sysOrg.Id;
        }

        public string Update(SysOrg sysOrg)
        {
            if (sysOrg.Id == sysOrg.ParentId)
            {
                throw new Exception("上级节点不能为自己");
            }
            UpdateTreeObj(sysOrg);

            return sysOrg.Id;
        }
        
        /// <summary>
        /// 删除指定ID的部门及其所有子部门
        /// </summary>
        public void DelOrgCascade(string[] ids)
        {
            var delOrgCascadeIds = UnitWork.Find<SysOrg>(u => ids.Contains(u.Id)).Select(u => u.CascadeId).ToArray();
            var delOrgIds = new List<string>();
            foreach (var cascadeId in delOrgCascadeIds)
            {
                delOrgIds.AddRange(UnitWork.Find<SysOrg>(u=>u.CascadeId.Contains(cascadeId)).Select(u =>u.Id).ToArray());
            }
            
            UnitWork.Delete<Relevance>(u =>u.Key == Define.USERORG && delOrgIds.Contains(u.SecondId));
            UnitWork.Delete<SysOrg>(u => delOrgIds.Contains(u.Id));
            UnitWork.Save();
            
        }

        /// <summary>
        /// 加载特定用户的部门
        /// </summary>
        /// <param name="userId">The user unique identifier.</param>
        public List<SysOrg> LoadForUser(string userId)
        {
            var result = from userorg in UnitWork.Find<Relevance>(null)
                join org in UnitWork.Find<SysOrg>(null) on userorg.SecondId equals org.Id
                where userorg.FirstId == userId && userorg.Key == Define.USERORG
                select org;
            return result.ToList();
        }

        public OrgManagerApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<SysOrg,OpenAuthDBContext> repository,IAuth auth, 
            RevelanceManagerApp revelanceApp) : base(unitWork, repository, auth)
        {
            _revelanceApp = revelanceApp;
        }
    }
}