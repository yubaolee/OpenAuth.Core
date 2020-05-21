using System;
using Autofac.Extensions.DependencyInjection;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.TestHost;
using Microsoft.EntityFrameworkCore;
using NUnit.Framework;
using OpenAuth.App.SSO;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Moq;
using Newtonsoft.Json;
using OpenAuth.App;
using OpenAuth.Repository;
using OpenAuth.WebApi.Controllers;
using OpenAuth.WebApi.Model;

namespace OpenAuth.WebApi.Test
{
    public class CheckControllerTest
    {
        private CheckController _controller;
        private ILogger _logger;
        private IHost _host;

        [SetUp]
        public void Init()
        {
            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("token")).Returns(new UserAuthSession { Account = "admin" });

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("token");


            var hostBuilder = Host.CreateDefaultBuilder()
                .ConfigureWebHostDefaults(webHostBuilder =>
                {
                    webHostBuilder.UseStartup<Startup>();
                    webHostBuilder.UseTestServer();
                    webHostBuilder.UseEnvironment("Development");
                  //  启动时调用了webapi的Startup ConfigureContainer造成下面的mock没起作用
                  //  webHostBuilder.ConfigureTestContainer();

                    webHostBuilder.ConfigureTestServices((services) =>
                    {
                        services.RemoveAll(typeof(IHostedService));
                        services.AddScoped(x => cachemock.Object);
                        services.AddScoped(x => httpContextAccessorMock.Object);
                        AutofacExt.InitForTest(services);
                    });
                })
                .UseServiceProviderFactory(new AutofacServiceProviderFactory())
                .ConfigureLogging((hostingContext, logging) =>
                {
                    logging.ClearProviders(); //去掉默认的日志
                    logging.AddFilter("System", LogLevel.Warning);
                    logging.AddFilter("Microsoft", LogLevel.Warning);
                    logging.AddLog4Net(); //默认的appsettings.json配置是warn级别，info是看不到的
                }).UseEnvironment("Development");
//                .ConfigureServices(u =>
//                {
//                    u.AddScoped(x => cachemock.Object);
//                    u.AddScoped(x => httpContextAccessorMock.Object);
//                    AutofacExt.InitForTest(u);
//
//                });
            
            
            // Build and start the IHost
            _host = hostBuilder.Start();
            
//          获取不到controller，但可以获取到其他注入的对象？ 
//           _controller = _host.GetTestServer().Services.GetRequiredService<CheckController>();
            _logger = _host.GetTestServer().Services.GetService<ILogger<CheckControllerTest>>();
        }

        [Test]
        public void LoadModuleTree()
        {
            // Create an HttpClient to send requests to the TestServer
            var client = _host.GetTestClient();

            var result = client.GetStringAsync("api/Check/GetModulesTree").Result;
            
            Console.WriteLine(result); 
        }


//        [Test]
//        public void Login()
//        {
//
//            var result = _controller.Login(new PassportLoginRequest
//            {
//                Account = Define.SYSTEM_USERNAME,
//                AppKey = "openauth",
//                Password = Define.SYSTEM_USERPWD
//            });
//
//            _logger.LogInformation(JsonHelper.Instance.Serialize(result));
//        }
    }
}
