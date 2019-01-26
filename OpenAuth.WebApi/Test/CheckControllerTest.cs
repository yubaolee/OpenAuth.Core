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
using Moq;
using OpenAuth.WebApi.Controllers;

namespace OpenAuth.WebApi.Test
{
    public class CheckControllerTest
    {
        private CheckController _controller;

        [SetUp]
        public void Init()
        {
            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("token")).Returns(new UserAuthSession { Account = "admin" });

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query["Token"]).Returns("token");


            var defaultBuilder = WebHost.CreateDefaultBuilder();
            var webHostBuilder = defaultBuilder.UseEnvironment("Development").UseStartup<Startup>()
                .ConfigureServices(u =>
                {
                    u.AddScoped(x => cachemock.Object);
                    u.AddScoped(x => httpContextAccessorMock.Object);
                });

            var server = new TestServer(webHostBuilder);
            _controller = server.Host.Services.GetService<CheckController>();
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
                Account = "System",
                AppKey = "openauth",
                Password = "123456"
            });

            Console.WriteLine(JsonHelper.Instance.Serialize(result));
        }
    }
}
