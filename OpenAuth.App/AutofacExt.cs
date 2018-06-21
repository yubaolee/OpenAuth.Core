﻿// ***********************************************************************
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

using System;
using System.Reflection;
using Autofac;
using Autofac.Extensions.DependencyInjection;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
using OpenAuth.App.SSO;
using OpenAuth.Repository;
using OpenAuth.Repository.Interface;
using IContainer = Autofac.IContainer;

namespace OpenAuth.App
{
    public static  class AutofacExt
    {
        private static IContainer _container;
        public static IContainer InitAutofac(IServiceCollection services)
        {
            var builder = new ContainerBuilder();
            if (services != null)
            {
                builder.Populate(services);
            }

            //注册数据库基础操作和工作单元
            builder.RegisterGeneric(typeof(BaseRepository<>)).As(typeof(IRepository<>)).PropertiesAutowired();
            builder.RegisterType(typeof(UnitWork)).As(typeof(IUnitWork)).PropertiesAutowired();

            //单元测试的时候注入controller
            //todo:但是在openauth.app/repository中测试时会失败，因为他们肯定没有opeanuth.webapi。。。
            //builder.RegisterAssemblyTypes(Assembly.Load("OpenAuth.WebApi"))
            //    .Where(
            //        t =>
            //            typeof(ControllerBase).IsAssignableFrom(t) &&
            //            t.Name.EndsWith("Controller", StringComparison.Ordinal));

            //注册app层
            builder.RegisterAssemblyTypes(Assembly.GetExecutingAssembly()).PropertiesAutowired();

            //缓存注入
            builder.RegisterType(typeof(UserAuthSession));
            builder.RegisterType<CacheContext>().As<ICacheContext>();
            builder.RegisterGeneric(typeof(ObjCacheProvider<>));

            builder.RegisterType<HttpContextAccessor>().As<IHttpContextAccessor>();

            _container = builder.Build();
            return _container;

        }

        /// <summary>
        /// 从容器中获取对象
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public static T GetFromFac<T>()
        {
            return _container.Resolve<T>();
        }
    }
}