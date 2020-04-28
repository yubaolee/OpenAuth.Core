using System;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using NUnit.Framework;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Test
{
    /// <summary>
    /// 测试分配权限
    /// </summary>
    class TestAccessObjs :TestBase
    {
        public override ServiceCollection GetService()
        {
            var services = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest"))
                .Returns(new UserAuthSession { Account = "System" });
            services.AddScoped(x => cachemock.Object);

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME])
                .Returns("tokentest");

            services.AddScoped(x => httpContextAccessorMock.Object);

            return services;
        }
        
        [Test]
        public void AssignOrgUsers()
        {
            var app = _autofacServiceProvider.GetService<RevelanceManagerApp>();
            var userApp = _autofacServiceProvider.GetService<UserManagerApp>();

            app.AssignOrgUsers(new AssignOrgUsers
            {
                OrgId = "8e31553c-cab8-4eb3-90b5-5f8ff1d21801",
                UserIds = new []{"96f63f9d-e8c8-4258-963e-3327ed7d6f56"}
            });

            var result = userApp.Load(new QueryUserListReq
            {
                orgId = "8e31553c-cab8-4eb3-90b5-5f8ff1d21801",
                page = 1,
                limit = 10
            });
            
            Console.WriteLine(JsonHelper.Instance.Serialize(result));

        }
    }
}
