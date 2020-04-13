using System;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using NUnit.Framework;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;

namespace OpenAuth.App.Test
{
    class TestUserApp :TestBase
    {
        public override ServiceCollection GetService()
        {
            var services = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest")).Returns(new UserAuthSession { Account = "test" });
            services.AddScoped(x => cachemock.Object);

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("tokentest");

            services.AddScoped(x => httpContextAccessorMock.Object);

            return services;
        }
        
        [Test]
        public void TestAdd()
        {
            var account = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            Console.WriteLine(account);
            var app = _autofacServiceProvider.GetService<UserManagerApp>();

            var newuser = new UpdateUserReq
            {
                Account = account,
                Name = account,
                OrganizationIds = "08f41bf6-4388-4b1e-bd3e-2ff538b44b1b,543a9fcf-4770-4fd9-865f-030e562be238",
            };
            app.AddOrUpdate(newuser);

            app.AddOrUpdate(new UpdateUserReq
            {
                Id = newuser.Id,
                Password = "newpassword",
                Account = account,
                Name = "新名字",
                OrganizationIds = "08f41bf6-4388-4b1e-bd3e-2ff538b44b1b",
            });
        }
    }
}
