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
    /// 数据库Id为numberic且为数据库自动生成的业务类型
    /// <para>该场景通常为SqlServer的自动增长类型和Oracle自带的Sequence</para>
    /// 业务层基类，UnitWork用于事务操作，Repository用于普通的数据库操作
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class BaseIntAutoGenApp<T, TDbContext> :BaseApp<T,TDbContext> where T : IntAutoGenEntity where TDbContext: DbContext
    {
        public BaseIntAutoGenApp(IUnitWork<TDbContext> unitWork, IRepository<T,TDbContext> repository, IAuth auth) : base(unitWork, repository, auth)
        {
            UnitWork = unitWork;
            Repository = repository;
            _auth = auth;
        }

        /// <summary>
        /// 按id批量删除
        /// </summary>
        /// <param name="ids"></param>
        public void Delete(int[] ids)
        {
            Repository.Delete(u => ids.Contains(u.Id));
        }

        public T Get(int id)
        {
            return Repository.FirstOrDefault(u => u.Id == id);
        }
    }
}