// ***********************************************************************
// Assembly         : FairUtility
// Author           : Yubao Li
// Created          : 08-27-2015
//
// Last Modified By : Yubao Li
// Last Modified On : 08-27-2015
// ***********************************************************************
// <copyright file="AutoMapperExt.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary></summary>
// ***********************************************************************

using System;
using AutoMapper;
using System.Collections;
using System.Collections.Generic;

namespace Infrastructure
{
    public static class AutoMapperExt
    {
        /// <summary>
        ///  类型映射
        /// </summary>
        public static T MapTo<T>(this object obj)
        {
            if (obj == null) return default(T);

            var config = new MapperConfiguration(cfg=>cfg.CreateMap(obj.GetType(),typeof(T)));
            var mapper = config.CreateMapper();
            return mapper.Map<T>(obj);
        }

        /// <summary>
        /// 集合列表类型映射
        /// </summary>
        public static List<TDestination> MapToList<TDestination>(this IEnumerable source)
        {
            Type sourceType = source.GetType().GetGenericArguments()[0];  //获取枚举的成员类型
            var config = new MapperConfiguration(cfg => cfg.CreateMap(sourceType, typeof(TDestination)));
            var mapper = config.CreateMapper();

            return mapper.Map<List<TDestination>>(source);
        }

        /// <summary>
        /// 集合列表类型映射
        /// </summary>
        public static List<TDestination> MapToList<TSource, TDestination>(this IEnumerable<TSource> source)
        {
            var config = new MapperConfiguration(cfg => cfg.CreateMap(typeof(TSource), typeof(TDestination)));
            var mapper = config.CreateMapper();

            return mapper.Map<List<TDestination>>(source);
        }

        /// <summary>
        /// 类型映射
        /// </summary>
        public static TDestination MapTo<TSource, TDestination>(this TSource source, TDestination destination)
            where TSource : class
            where TDestination : class
        {
            if (source == null) return destination;

            var config = new MapperConfiguration(cfg => cfg.CreateMap(typeof(TSource), typeof(TDestination)));
            var mapper = config.CreateMapper();
            return mapper.Map<TDestination>(source);
        }

    }
}