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
// <summary>IOC初始化</summary>
// ***********************************************************************

using Autofac;
using Autofac.Configuration;
using Autofac.Integration.Mvc;
using OpenAuth.App;
using System.Reflection;
using System.Web.Mvc;
using OpenAuth.Domain.Interface;
using OpenAuth.Repository;

namespace OpenAuth.Mvc
{
    internal static  class AutofacExt
    {
        public static void InitAutofac()
        {
            var builder = new ContainerBuilder();

            //泛型注册
            builder.RegisterGeneric(typeof(BaseRepository<>)).As(typeof(IRepository<>));

            //应用层注册
            builder.RegisterModule(new ConfigurationSettingsReader("autofac"));
            builder.RegisterType<LoginApp>();
            builder.RegisterType<OrgManagerApp>();
            builder.RegisterType<UserManagerApp>();
            builder.RegisterType<RoleManagerApp>();
            builder.RegisterType<ModuleManagerApp>();
            builder.RegisterType<ModuleElementManagerApp>();
            builder.RegisterType<CategoryManagerApp>();
            builder.RegisterType<ResourceManagerApp>();       

            // Register your MVC controllers.
            builder.RegisterControllers(typeof(MvcApplication).Assembly);

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
        /// 从依赖容器里面获取
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public static T GetFromFac<T>()
        {
            return (T)DependencyResolver.Current.GetService(typeof(T));
        }
    }
}