using System;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using NUnit.Framework;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Test
{
    class TestOrgApp :TestBase
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
            var orgname = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            Console.WriteLine(orgname);
            var app = _autofacServiceProvider.GetService<OrgManagerApp>();

            var id = app.Add(new Org
            {
                Name = orgname,
                ParentId = ""
            });

            var org = app.Get(id);
            Console.WriteLine(JsonHelper.Instance.Serialize(org));
        }
    }
}
