using System;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.TestHost;
using NUnit.Framework;
using OpenAuth.App.SSO;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Moq;
using OpenAuth.App;
using OpenAuth.WebApi.Controllers;

namespace OpenAuth.WebApi.Test
{
    public class CheckControllerTest
    {
        private CheckController _controller;
        private ILogger _logger;

        [SetUp]
        public void Init()
        {
            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("token")).Returns(new UserAuthSession { Account = "admin" });

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("token");


            var defaultBuilder = WebHost.CreateDefaultBuilder();
            var webHostBuilder = defaultBuilder.ConfigureLogging((hostingContext, logging) =>
                {
                    logging.ClearProviders();  //去掉默认的日志
                    logging.AddFilter("System", LogLevel.Warning);
                    logging.AddFilter("Microsoft", LogLevel.Warning);
                    logging.AddLog4Net();  //默认的appsettings.json配置是warn级别，info是看不到的
                }).UseEnvironment("Development").UseStartup<Startup>()
                .ConfigureServices(u =>
                {
                    u.AddScoped(x => cachemock.Object);
                    u.AddScoped(x => httpContextAccessorMock.Object);
                });

            var server = new TestServer(webHostBuilder);
            _controller = server.Host.Services.GetService<CheckController>();
            _logger = server.Host.Services.GetService<ILogger<CheckControllerTest>>();
        }

        [Test]
        public void LoadModuleTree()
        {
            var modules = _controller.GetModulesTree();
            Console.WriteLine(JsonHelper.Instance.Serialize(modules));
        }


        [Test]
        public void Login()
        {

            var result = _controller.Login(new PassportLoginRequest
            {
                Account = Define.SYSTEM_USERNAME,
                AppKey = "openauth",
                Password = Define.SYSTEM_USERPWD
            });

            _logger.LogInformation(JsonHelper.Instance.Serialize(result));
        }
    }
}
