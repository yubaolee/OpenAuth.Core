// ***********************************************************************
// Assembly         : FairUtility
// Author           : Yubao Li
// Created          : 08-18-2015
//
// Last Modified By : Yubao Li
// Last Modified On : 08-18-2015
// ***********************************************************************
// <copyright file="DynamicLinq.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>动态linq</summary>
// ***********************************************************************

using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace Infrastructure
{
    public static class DynamicLinq
    {
        public static ParameterExpression CreateLambdaParam<T>(string name)
        {
            return Expression.Parameter(typeof(T), name);
        }

        /// <summary>
        /// 创建linq表达示的body部分
        /// </summary>
        public static Expression GenerateBody<T>(this ParameterExpression param, Filter filterObj)
        {
            PropertyInfo property = typeof(T).GetProperty(filterObj.Key);

            //组装左边
            Expression left = Expression.Property(param, property);
            //组装右边
            Expression right = null;

            if (property.PropertyType == typeof(int))
            {
                right = Expression.Constant(int.Parse(filterObj.Value));
            }
            else if (property.PropertyType == typeof(DateTime))
            {
                right = Expression.Constant(DateTime.Parse(filterObj.Value));
            }
            else if (property.PropertyType == typeof(string))
            {
                right = Expression.Constant((filterObj.Value));
            }
            else if (property.PropertyType == typeof(decimal))
            {
                right = Expression.Constant(decimal.Parse(filterObj.Value));
            }
            else if (property.PropertyType == typeof(Guid))
            {
                right = Expression.Constant(Guid.Parse(filterObj.Value));
            }
            else if (property.PropertyType == typeof(bool))
            {
                right = Expression.Constant(filterObj.Value.Equals("1"));
            }
            else if (property.PropertyType == typeof(Guid?))
            {
                left = Expression.Property(left, "Value");
                right = Expression.Constant(Guid.Parse(filterObj.Value));
            }
            else
            {
                throw new Exception("暂不能解析该Key的类型");
            }

            //c.XXX=="XXX"
            Expression filter = Expression.Equal(left, right);
            switch (filterObj.Contrast)
            {
                case "<=":
                    filter = Expression.LessThanOrEqual(left, right);
                    break;

                case "<":
                    filter = Expression.LessThan(left, right);
                    break;

                case ">":
                    filter = Expression.GreaterThan(left, right);
                    break;

                case ">=":
                    filter = Expression.GreaterThanOrEqual(left, right);
                    break;
                case "!=":
                    filter = Expression.NotEqual(left, right);
                    break;

                case "like":
                    filter = Expression.Call(left, typeof(string).GetMethod("Contains", new Type[] { typeof(string) }),
                                 Expression.Constant(filterObj.Value));
                    break;
                case "not in":
                    var listExpression = Expression.Constant(filterObj.Value.Split(',').ToList()); //数组
                    var method = typeof(List<string>).GetMethod("Contains", new Type[] { typeof(string) }); //Contains语句
                    filter = Expression.Not(Expression.Call(listExpression, method, left));
                    break;
                case "in":
                    var lExp = Expression.Constant(filterObj.Value.Split(',').ToList()); //数组
                    var methodInfo = typeof(List<string>).GetMethod("Contains", new Type[] { typeof(string) }); //Contains语句
                    filter = Expression.Call(lExp, methodInfo, left);
                    break;
            }

            return filter;
        }

        public static Expression<Func<T, bool>> GenerateTypeBody<T>(this ParameterExpression param, Filter filterObj)
        {
            return (Expression<Func<T, bool>>)(param.GenerateBody<T>(filterObj));
        }

        /// <summary>
        /// 创建完整的lambda
        /// </summary>
        public static LambdaExpression GenerateLambda(this ParameterExpression param, Expression body)
        {
            //c=>c.XXX=="XXX"
            return Expression.Lambda(body, param);
        }

        public static Expression<Func<T, bool>> GenerateTypeLambda<T>(this ParameterExpression param, Expression body)
        {
            return (Expression<Func<T, bool>>)(param.GenerateLambda(body));
        }

        public static Expression AndAlso(this Expression expression, Expression expressionRight)
        {
            return Expression.AndAlso(expression, expressionRight);
        }

        public static Expression Or(this Expression expression, Expression expressionRight)
        {
            return Expression.Or(expression, expressionRight);
        }

        public static Expression And(this Expression expression, Expression expressionRight)
        {
            return Expression.And(expression, expressionRight);
        }

        //系统已经有该函数的实现
        //public static IQueryable<T> Where<T>(this IQueryable<T> query, Expression expression)
        //{
        //    Expression expr = Expression.Call(typeof(Queryable), "Where", new[] { typeof(T) },
        //       Expression.Constant(query), expression);
        //    //生成动态查询
        //    IQueryable<T> result = query.Provider.CreateQuery<T>(expr);
        //    return result;
        //}

        public static IQueryable<T> GenerateFilter<T>(this IQueryable<T> query, string filterjson)
        {
            if (!string.IsNullOrEmpty(filterjson))
            {
                var filters = JsonHelper.Instance.Deserialize<IEnumerable<Filter>>(filterjson);
                var param = CreateLambdaParam<T>("c");

                Expression result = Expression.Constant(true);
                foreach (var filter in filters)
                {
                    result = result.AndAlso(param.GenerateBody<T>(filter));
                }

                query = query.Where(param.GenerateTypeLambda<T>(result));
            }
            return query;
        }
    }
}