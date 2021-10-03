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
    /// <para>如用户管理：Class UserManagerApp:BaseApp&lt;User&gt;</para>
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <typeparam name="TDbContext"></typeparam>
    public class BaseStringApp<T, TDbContext> :BaseApp<T,TDbContext> where T : StringEntity where TDbContext: DbContext
    {

        public BaseStringApp(IUnitWork<TDbContext> unitWork, IRepository<T,TDbContext> repository, IAuth auth) : base(unitWork, repository, auth)
        {
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