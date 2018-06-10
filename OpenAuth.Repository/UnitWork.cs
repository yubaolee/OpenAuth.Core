using System;
using System.Linq;
using System.Linq.Expressions;
using Infrastructure;
using Microsoft.EntityFrameworkCore;
using OpenAuth.Repository.Core;
using OpenAuth.Repository.Interface;
using Z.EntityFramework.Plus;

namespace OpenAuth.Repository
{
   public  class UnitWork: IUnitWork
   {
       protected OpenAuthDBContext Context = new OpenAuthDBContext();


       /// <summary>
        /// 根据过滤条件，获取记录
        /// </summary>
        /// <param name="exp">The exp.</param>
        public IQueryable<T> Find<T>(Expression<Func<T, bool>> exp = null) where T : class 
        {
            return Filter(exp);
        }

        public bool IsExist<T>(Expression<Func<T, bool>> exp) where T : class
        {
            return Context.Set<T>().Any(exp);
        }

        /// <summary>
        /// 查找单个
        /// </summary>
        public T FindSingle<T>(Expression<Func<T, bool>> exp) where T:class 
        {
            return Context.Set<T>().AsNoTracking().FirstOrDefault(exp);
        }

        /// <summary>
        /// 得到分页记录
        /// </summary>
        /// <param name="pageindex">The pageindex.</param>
        /// <param name="pagesize">The pagesize.</param>
        /// <param name="orderby">排序，格式如："Id"/"Id descending"</param>
        public IQueryable<T> Find<T>(int pageindex, int pagesize, string orderby = "", Expression<Func<T, bool>> exp = null) where T : class
        {
            if (pageindex < 1) pageindex = 1;
            if (string.IsNullOrEmpty(orderby))
                orderby = "Id descending";

            return Filter(exp).OrderBy(orderby).Skip(pagesize * (pageindex - 1)).Take(pagesize);
        }

        /// <summary>
        /// 根据过滤条件获取记录数
        /// </summary>
        public int GetCount<T>(Expression<Func<T, bool>> exp = null) where T : class
        {
            return Filter(exp).Count();
        }

        public void Add<T>(T entity) where T : Entity
        {
            if (string.IsNullOrEmpty(entity.Id))
            {
                entity.Id = Guid.NewGuid().ToString();
            }
            Context.Set<T>().Add(entity);
        }

        /// <summary>
        /// 批量添加
        /// </summary>
        /// <param name="entities">The entities.</param>
        public void BatchAdd<T>(T[] entities) where T : Entity
        {
            foreach (var entity in entities)
            {
                entity.Id = Guid.NewGuid().ToString();
            }
            Context.Set<T>().AddRange(entities);
        }

        public void Update<T>(T entity) where T:class
        {
            var entry = this.Context.Entry(entity);
            entry.State = EntityState.Modified;

            //如果数据没有发生变化
            if (!this.Context.ChangeTracker.HasChanges())
            {
                entry.State = EntityState.Unchanged;
            }

        }

        public void Delete<T>(T entity) where T:class
        {
            Context.Set<T>().Remove(entity);
        }

        /// <summary>
        /// 按指定id更新实体,会更新整个实体
        /// </summary>
        /// <param name="identityExp">The identity exp.</param>
        /// <param name="entity">The entity.</param>
        public void Update<T>(Expression<Func<T, object>> identityExp, T entity) where T:class
        {
            //Context.Set<T>().AddOrUpdate(identityExp, entity);
        }

        /// <summary>
        /// 实现按需要只更新部分更新
        /// <para>如：Update(u =>u.Id==1,u =>new User{Name="ok"});</para>
        /// </summary>
        /// <param name="where">The where.</param>
        /// <param name="entity">The entity.</param>
        public void Update<T>(Expression<Func<T, bool>> where, Expression<Func<T, T>> entity) where T:class
        {
            Context.Set<T>().Where(where).Update(entity);
        }

        public virtual void Delete<T>(Expression<Func<T, bool>> exp) where T : class
        {
            Context.Set<T>().RemoveRange(Filter(exp));
        }

        public void Save()
        {
            //try
            //{
                Context.SaveChanges();
            //}
            //catch (DbEntityValidationException e)
            //{
            //    throw new Exception(e.EntityValidationErrors.First().ValidationErrors.First().ErrorMessage);
            //}
          
        }

        private IQueryable<T> Filter<T>(Expression<Func<T, bool>> exp) where T : class
        {
            var dbSet = Context.Set<T>().AsNoTracking().AsQueryable();
            if (exp != null)
                dbSet = dbSet.Where(exp);
            return dbSet;
        }

       public void ExecuteSql(string sql)
       {
            Context.Database.ExecuteSqlCommand(sql);
        }

    }
}
