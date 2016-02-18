using System;
using System.Data.Entity;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Linq.Expressions;
using EntityFramework.Extensions;
using OpenAuth.Domain.Interface;
using OpenAuth.Repository.Models;
using Infrastructure;

namespace OpenAuth.Repository
{
   public  class BaseRepository<T> :IRepository<T> where T :class
   {
       protected OpenAuthDBContext Context = new OpenAuthDBContext();

       /// <summary>
       /// 根据过滤条件，获取记录
       /// </summary>
       /// <param name="exp">The exp.</param>
       public IQueryable<T> Find(Expression<Func<T, bool>> exp = null)
       {
           return Filter(exp);
       }

       /// <summary>
       /// 查找单个
       /// </summary>
       public T FindSingle(Expression<Func<T, bool>> exp)
       {
           return Context.Set<T>().AsNoTracking().FirstOrDefault(exp);
       }

       /// <summary>
       /// 得到分页记录
       /// </summary>
       /// <param name="pageindex">The pageindex.</param>
       /// <param name="pagesize">The pagesize.</param>
       /// <param name="orderby">排序，格式如："Id"/"Id descending"</param>
       public IQueryable<T> Find(int pageindex, int pagesize, string orderby = "", Expression<Func<T, bool>> exp = null)
       {
           if (pageindex < 1) pageindex = 1;
           if (string.IsNullOrEmpty(orderby))
               orderby = "Id descending";

           return Filter(exp).OrderBy(orderby).Skip(pagesize * (pageindex - 1)).Take(pagesize);
       }

       /// <summary>
       /// 根据过滤条件获取记录数
       /// </summary>
       public int GetCount(Expression<Func<T, bool>> exp = null)
       {
           return Filter(exp).Count();
       }

       public void Add(T entity)
       {
           Context.Set<T>().Add(entity);
           Save();
       }

       public void Update(T entity)
       {
           var entry = this.Context.Entry(entity);
           //todo:如果状态没有任何更改，会报错
           entry.State = EntityState.Modified;

           Save();
       }

       public void Delete(T entity)
       {
           Context.Set<T>().Remove(entity);
           Save();
       }

       public void Update(Expression<Func<T, object>> identityExp, T entity)
       {
           //TODO: 暂时有问题，EntityFramework.Extension的Update必须有new操作
          // Context.Set<T>().Where(exp).Update(u => entity);
           Context.Set<T>().AddOrUpdate(identityExp, entity);
            Save();
       }

       public void Delete(Expression<Func<T, bool>> exp)
       {
           Context.Set<T>().Where(exp).Delete();
       }

       public void Save()
       {
           Context.SaveChanges();
       }

       private IQueryable<T> Filter(Expression<Func<T, bool>> exp)
       {
           var dbSet = Context.Set<T>().AsQueryable();
           if (exp != null)
               dbSet = dbSet.Where(exp);
           return dbSet;
       }
   }
}
