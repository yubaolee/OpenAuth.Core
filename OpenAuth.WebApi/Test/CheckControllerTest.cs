using System;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using NUnit.Framework;
using OpenAuth.App.SSO;
using OpenAuth.App.Test;
using OpenAuth.WebApi.Areas.SSO.Controllers;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Moq;
using OpenAuth.App;
using OpenAuth.WebApi.Controllers;

namespace OpenAuth.WebApi.Test
{
    public class CheckControllerTest : TestBase
    {

        //如果要测试controller，则要重写
        public override ServiceCollection GetService()
        {
            var serviceCollection = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest")).Returns(new UserAuthSession { Account = "admin" });
            serviceCollection.AddScoped(x => cachemock.Object);

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query["Token"]).Returns("tokentest");

            serviceCollection.AddScoped(x => httpContextAccessorMock.Object);

            serviceCollection.AddMvc().AddControllersAsServices();
            serviceCollection.AddScoped<CheckController>();

            //读取配置文件
            IConfigurationBuilder configurationBuilder = new ConfigurationBuilder();
            // Duplicate here any configuration sources you use.
            configurationBuilder.AddJsonFile("AppSettings.json");
            IConfiguration configuration = configurationBuilder.Build();
            serviceCollection.Configure<AppSetting>(configuration.GetSection("AppSetting"));

            return serviceCollection;
        }

        [Test]
        public void LoadModuleTree()
        {
            var checkController = _autofacServiceProvider.GetService<CheckController>();

            Assert.NotNull(checkController);

            var modules = checkController.GetModulesTree();
            Console.WriteLine(JsonHelper.Instance.Serialize(modules));
        }


        [Test]
        public void Login()
        {
            var usermanager = _autofacServiceProvider.GetService<UserManagerApp>();
            Assert.NotNull(usermanager);

            var checkController = _autofacServiceProvider.GetService<CheckController>();

            Assert.NotNull(checkController);
            //var charckController = new CheckController();
            var result = checkController.Login(new PassportLoginRequest
            {
                Account = "System",
                AppKey = "openauth",
                Password = "123456"
            });

            Console.WriteLine(JsonHelper.Instance.Serialize(result));
        }
    }
}
