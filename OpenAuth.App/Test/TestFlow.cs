using System;
using Microsoft.AspNetCore.Http;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Test
{
    public class TestFlow :TestBase
    {
        //测试流程需要模拟登录用户
        public override ServiceCollection GetService()
        {
            var services = new ServiceCollection();

            var authMock = new Mock<IAuth>();
            authMock.Setup(x => x.GetUserName("tokentest")).Returns("System");
            authMock.Setup(x => x.GetCurrentUser("")).Returns(new UserWithAccessedCtrls
            {
                User = new User
                {
                    Account = "System",
                    Id = Guid.Empty.ToString(),
                    Name = "System"
                }
            });
            services.AddScoped(x => authMock.Object);

            var httpContextMock = new Mock<HttpContext>();
            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Cookies["token"]).Returns("tokentest");
            httpContextAccessorMock.Setup(x => x.HttpContext).Returns(httpContextMock.Object);

            services.AddScoped(x => httpContextAccessorMock.Object);

            return services;
        }


        [Test]
        public void Verificate()
        {
            var app = _autofacServiceProvider.GetService<FlowInstanceApp>();
            app.Verification(new VerificationReq
            {
                FlowInstanceId = "d8fa445f-edd9-4604-8d9e-b17ba921f9dd",
                VerificationFinally = "1"
            });
        }
    }
}
