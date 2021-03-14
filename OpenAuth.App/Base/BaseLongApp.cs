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
    /// ⭐⭐数据库Id为numberic类型的数据表相关业务使用该基类⭐⭐
    /// 业务层基类，UnitWork用于事务操作，Repository用于普通的数据库操作
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class BaseLongApp<T, TDbContext> :BaseApp<T,TDbContext> where T : LongEntity where TDbContext: DbContext
    {


        public BaseLongApp(IUnitWork<TDbContext> unitWork, IRepository<T,TDbContext> repository, IAuth auth) : base(unitWork, repository,auth)
        {
        }
        

        /// <summary>
        /// 按id批量删除
        /// </summary>
        /// <param name="ids"></param>
        public void Delete(long[] ids)
        {
            Repository.Delete(u => ids.Contains(u.Id));
        }

        public T Get(long id)
        {
            return Repository.FirstOrDefault(u => u.Id == id);
        }
    }
}