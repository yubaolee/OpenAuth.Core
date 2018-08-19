using System;
using Infrastructure;
using Microsoft.Extensions.Configuration;
using NUnit.Framework;
using OpenAuth.App.SSO;
using OpenAuth.App.Test;
using OpenAuth.WebApi.Areas.SSO.Controllers;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
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
