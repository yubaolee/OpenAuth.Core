using System;
using System.Linq;
using Infrastructure;
using Microsoft.EntityFrameworkCore;
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
    public class BaseStringApp<T, TDbContext> :BaseApp<T,TDbContext> where T : StringEntity where TDbContext: DbContext
    {
        /// <summary>
        /// 用于普通的数据库操作
        /// </summary>
        protected IRepository<T, TDbContext> Repository;

        /// <summary>
        /// 用于事务操作
        /// <para>使用详见：http://doc.openauth.me/core/unitwork.html</para>
        /// </summary>
        protected IUnitWork<TDbContext> UnitWork;

        protected IAuth _auth;

        public BaseStringApp(IUnitWork<TDbContext> unitWork, IRepository<T,TDbContext> repository, IAuth auth) : base(unitWork, repository, auth)
        {
            UnitWork = unitWork;
            Repository = repository;
            _auth = auth;
        }

        /// <summary>
        /// 按id批量删除
        /// </summary>
        /// <param name="ids"></param>
        public virtual void Delete(string[] ids)
        {
            Repository.Delete(u => ids.Contains(u.Id));
        }

        public T Get(string id)
        {
            return Repository.FirstOrDefault(u => u.Id == id);
        }

    }
}