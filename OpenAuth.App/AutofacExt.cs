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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.Loader;
using Autofac;
using Autofac.Extensions.DependencyInjection;
using Autofac.Extras.Quartz;
using Infrastructure.Cache;
using Infrastructure.Extensions.AutofacManager;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyModel;
using OpenAuth.App.Interface;
using OpenAuth.App.SSO;
using OpenAuth.Repository;
using OpenAuth.Repository.Interface;
using IContainer = Autofac.IContainer;

namespace OpenAuth.App
{
    public static  class AutofacExt
    {
        private static IContainer _container;
        public static IContainer InitForTest(IServiceCollection services)
        {
            var builder = new ContainerBuilder();
           
            //注册数据库基础操作和工作单元
            services.AddScoped(typeof(IRepository<,>), typeof(BaseRepository<,>));
            services.AddScoped(typeof(IUnitWork<>), typeof(UnitWork<>));

            //注入授权
            builder.RegisterType(typeof(LocalAuth)).As(typeof(IAuth));

            //注册app层
            builder.RegisterAssemblyTypes(Assembly.GetExecutingAssembly());

            //防止单元测试时已经注入
            if (services.All(u => u.ServiceType != typeof(ICacheContext)))
            {
                services.AddScoped(typeof(ICacheContext), typeof(CacheContext));
            }

            if (services.All(u => u.ServiceType != typeof(IHttpContextAccessor)))
            {
                services.AddScoped(typeof(IHttpContextAccessor), typeof(HttpContextAccessor));
            }
            
            InitDependency(builder);
            
            builder.RegisterModule(new QuartzAutofacFactoryModule());

            builder.Populate(services);

            _container = builder.Build();
            return _container;

        }
        
        
        public static void InitAutofac(ContainerBuilder builder)
        {
            
            //注册数据库基础操作和工作单元
            builder.RegisterGeneric(typeof(BaseRepository<,>)).As(typeof(IRepository<,>));
            builder.RegisterGeneric(typeof(UnitWork<>)).As(typeof(IUnitWork<>));
            //注入授权
            builder.RegisterType(typeof(LocalAuth)).As(typeof(IAuth)).InstancePerLifetimeScope();
            
            //注册app层
            builder.RegisterAssemblyTypes(Assembly.GetExecutingAssembly());
            
            builder.RegisterType(typeof(CacheContext)).As(typeof(ICacheContext));
            builder.RegisterType(typeof(HttpContextAccessor)).As(typeof(IHttpContextAccessor));
            
            InitDependency(builder);
            
            builder.RegisterModule(new QuartzAutofacFactoryModule());
        }


        /// <summary>
        /// 注入所有继承了IDependency接口
        /// </summary>
        /// <param name="builder"></param>
        private static void InitDependency(ContainerBuilder builder)
        {
            Type baseType = typeof(IDependency);
            var compilationLibrary = DependencyContext.Default
                .CompileLibraries
                .Where(x => !x.Serviceable
                            && x.Type == "project")
                .ToList();
            var count1 = compilationLibrary.Count;
            List<Assembly> assemblyList = new List<Assembly>();

            foreach (var _compilation in compilationLibrary)
            {
                try
                {
                    assemblyList.Add(AssemblyLoadContext.Default.LoadFromAssemblyName(new AssemblyName(_compilation.Name)));
                }
                catch (Exception ex)
                {
                    Console.WriteLine(_compilation.Name + ex.Message);
                }
            }
            
            builder.RegisterAssemblyTypes(assemblyList.ToArray())
                .Where(type => baseType.IsAssignableFrom(type) && !type.IsAbstract)
                .AsSelf().AsImplementedInterfaces()
                .InstancePerLifetimeScope();
        }
    }
}