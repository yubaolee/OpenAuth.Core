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
using System.Web.Mvc;
using Autofac;
using Autofac.Configuration;
using Autofac.Integration.Mvc;
using OpenAuth.App;
using OpenAuth.Domain.Interface;
using OpenAuth.Domain.Service;
using OpenAuth.Repository;

namespace OpenAuth.WebApi
{
    internal static  class AutofacExt
    {
        public static void InitAutofac()
        {
            var builder = new ContainerBuilder();

            //注册数据库基础操作和工作单元
            builder.RegisterGeneric(typeof(BaseRepository<>)).As(typeof(IRepository<>));
            builder.RegisterType(typeof (UnitWork)).As(typeof (IUnitWork));

            //注册WebConfig中的配置
            builder.RegisterModule(new ConfigurationSettingsReader("autofac"));

            //注册app层
            builder.RegisterAssemblyTypes(Assembly.GetAssembly(typeof (AuthorizeApp)));

            //注册领域服务
            builder.RegisterAssemblyTypes(Assembly.GetAssembly(typeof(AuthoriseService)))
                .Where(u =>u.Namespace== "OpenAuth.Domain.Service");

            // OPTIONAL: Register model binders that require DI.
            builder.RegisterModelBinders(Assembly.GetExecutingAssembly());
            builder.RegisterModelBinderProvider();

            // OPTIONAL: Register web abstractions like HttpContextBase.
            builder.RegisterModule<AutofacWebTypesModule>();

            // OPTIONAL: Enable property injection in view pages.
            builder.RegisterSource(new ViewRegistrationSource());

            // OPTIONAL: Enable property injection into action filters.
            builder.RegisterFilterProvider();

            // Set the dependency resolver to be Autofac.
            var container = builder.Build();
            DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
        }

        /// <summary>
        /// 从容器中获取对象
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public static T GetFromFac<T>()
        {
            return (T)DependencyResolver.Current.GetService(typeof(T));
        }
    }
}