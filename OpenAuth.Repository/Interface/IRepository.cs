// ***********************************************************************
// Assembly         : OpenAuth.Domain
// Author           : yubaolee
// Created          : 10-25-2015
//
// Last Modified By : yubaolee
// Last Modified On : 10-25-2015
// ***********************************************************************
// <copyright file="IRepository.cs" company="www.cnblogs.com/yubaolee">
//     Copyright (c) www.cnblogs.com/yubaolee. All rights reserved.
// </copyright>
// <summary>仓储接口</summary>
// ***********************************************************************

using System;
using System.Linq;
using System.Linq.Expressions;

namespace OpenAuth.Repository.Interface
{
    public interface IRepository<T> where T : class
    {
        T FindSingle(Expression<Func<T, bool>> exp = null);
        bool IsExist(Expression<Func<T, bool>> exp);
        IQueryable<T> Find(Expression<Func<T, bool>> exp = null);

        IQueryable<T> Find(int pageindex = 1, int pagesize = 10, string orderby = "",
            Expression<Func<T, bool>> exp = null);

        int GetCount(Expression<Func<T, bool>> exp = null);

        void Add(T entity);

        void BatchAdd(T[] entities);

        /// <summary>
        /// 更新一个实体的所有属性
        /// </summary>
        void Update(T entity);

        void Delete(T entity);


        /// <summary>
        /// 实现按需要只更新部分更新
        /// <para>如：Update(u =>u.Id==1,u =>new User{Name="ok"});</para>
        /// </summary>
        /// <param name="where">更新条件</param>
        /// <param name="entity">更新后的实体</param>
        void Update(Expression<Func<T, bool>> where, Expression<Func<T, T>> entity);
        /// <summary>
        /// 批量删除
        /// </summary>
        void Delete(Expression<Func<T, bool>> exp);

        void Save();

        int ExecuteSql(string sql);
    }
}