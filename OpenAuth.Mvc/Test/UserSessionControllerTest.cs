// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : 李玉宝
// Created          : 07-02-2018
//
// Last Modified By : 李玉宝
// Last Modified On : 07-02-2018
// ***********************************************************************
// <copyright file="UserSessionControllerTest.cs" company="OpenAuth.Mvc">
//     Copyright (c) http://www.openauth.me. All rights reserved.
// </copyright>
// <summary>
// 测试加载用户菜单
// </summary>
// ***********************************************************************

using System;
using System.Diagnostics;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using NUnit.Framework;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.App.Test;
using OpenAuth.Mvc.Controllers;

namespace OpenAuth.Mvc.Test
{
    public class UserSessionControllerTest : TestBase
    {

        //如果要测试controller，则要重写
        public override ServiceCollection GetService()
        {
            var services = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest")).Returns(new UserAuthSession{Account = Define.SYSTEM_USERNAME});
            services.AddScoped(x => cachemock.Object);

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("tokentest");

            services.AddScoped(x => httpContextAccessorMock.Object);

            services.AddMvc().AddControllersAsServices();
            services.AddScoped<UserSessionController>();

            //读取配置文件
            IConfigurationBuilder configurationBuilder = new ConfigurationBuilder();
            // Duplicate here any configuration sources you use.
            configurationBuilder.AddJsonFile("AppSettings.json");
            IConfiguration configuration = configurationBuilder.Build();
            services.Configure<AppSetting>(configuration.GetSection("AppSetting"));

            return services;
        }


        [Test]
        public void GetModulesTree()
        {
            Stopwatch watch = Stopwatch.StartNew();
            var controller = _autofacServiceProvider.GetService<UserSessionController>();

            var result =  controller.GetModulesTree();
            Console.WriteLine(JsonHelper.Instance.Serialize(result));
            watch.Stop();
            Console.WriteLine($"总耗时:{watch.ElapsedMilliseconds}");
        }
    }
}
