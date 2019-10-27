using System;
using System.Linq;
using System.Linq.Expressions;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.Repository.Core;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 业务层基类，UnitWork用于事务操作，Repository用于普通的数据库操作
    /// <para>如用户管理：Class UserManagerApp:BaseApp<User></para>
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class BaseApp<T> where T : Entity
    {
        /// <summary>
        /// 用于普通的数据库操作
        /// </summary>
        /// <value>The repository.</value>
        protected IRepository<T> Repository;

        /// <summary>
        /// 用于事务操作
        /// </summary>
        /// <value>The unit work.</value>
        protected IUnitWork UnitWork;

        protected IAuth _auth;

        public BaseApp(IUnitWork unitWork, IRepository<T> repository, IAuth auth)
        {
            UnitWork = unitWork;
            Repository = repository;
            _auth = auth;
        }

        /// <summary>
        ///  获取当前登录用户的数据访问权限
        /// </summary>
        /// <param name=""parameterName>linq表达式参数的名称，如u=>u.name中的"u"</param>
        /// <returns></returns>
        protected IQueryable<T> GetDataPrivilege(string parametername)
        {
            var moduleName = typeof(T).Name;
            var rule = UnitWork.FindSingle<DataPrivilegeRule>(u => u.SourceCode == moduleName);
            if (rule == null) return UnitWork.Find<T>(null);
            //todo:在这里替换登录用户的信息
            return UnitWork.Find<T>(null).GenerateFilter(parametername,
                JsonHelper.Instance.Deserialize<FilterGroup>(rule.PrivilegeRules));
        }

        /// <summary>
        /// 按id批量删除
        /// </summary>
        /// <param name="ids"></param>
        public void Delete(string[] ids)
        {
            Repository.Delete(u => ids.Contains(u.Id));
        }

        public T Get(string id)
        {
            return Repository.FindSingle(u => u.Id == id);
        }

        /// <summary>
        /// 如果一个类有层级结构（树状），则修改该节点时，要修改该节点的所有子节点
        /// //修改对象的级联ID，生成类似XXX.XXX.X.XX
        /// </summary>
        /// <typeparam name="U">U必须是一个继承TreeEntity的结构</typeparam>
        /// <param name="entity"></param>
        public void ChangeModuleCascade<U>(U entity) where U : TreeEntity
        {
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
                var parentOrg = UnitWork.FindSingle<U>(o => o.Id == entity.ParentId);
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