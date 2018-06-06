// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 10-26-2015
//
// Last Modified By : yubaolee
// Last Modified On : 10-26-2015
// ***********************************************************************
// <copyright file="AutofacExt.cs" company="www.cnblogs.com/yubaolee">
//     Copyright (c) www.cnblogs.com/yubaolee. All rights reserved.
// </copyright>
// <summary>IOC扩展</summary>
// ***********************************************************************

using System.Reflection;
using Autofac;
using Autofac.Extensions.DependencyInjection;
using Infrastructure.Cache;
using Microsoft.Extensions.DependencyInjection;
using OpenAuth.App.SSO;
using OpenAuth.Repository;
using OpenAuth.Repository.Interface;
using IContainer = Autofac.IContainer;

namespace OpenAuth.App
{
    public static  class AutofacExt
    {
        public static IContainer InitAutofac(IServiceCollection services)
        {
            var builder = new ContainerBuilder();

            builder.Populate(services);

            //注册数据库基础操作和工作单元
            builder.RegisterGeneric(typeof(BaseRepository<>)).As(typeof(IRepository<>)).PropertiesAutowired();
            builder.RegisterType(typeof(UnitWork)).As(typeof(IUnitWork)).PropertiesAutowired();

            //注册app层
            builder.RegisterAssemblyTypes(Assembly.GetExecutingAssembly()).PropertiesAutowired();

            //缓存注入
            builder.RegisterType(typeof(UserAuthSession));
            builder.RegisterType<CacheContext>().As<ICacheContext>();
            builder.RegisterGeneric(typeof(ObjCacheProvider<>));

            return builder.Build();

        }

        /// <summary>
        /// 从容器中获取对象
        /// </summary>
        /// <typeparam name="T"></typeparam>
        //public static T GetFromFac<T>()
        //{
        //    return _container.Resolve<T>();
        //    //   return (T)DependencyResolver.Current.GetService(typeof(T));
        //}
    }
}