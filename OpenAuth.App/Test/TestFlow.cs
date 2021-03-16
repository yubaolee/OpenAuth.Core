using System;
using System.Net.Http;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;
using Yitter.IdGenerator;

namespace OpenAuth.App.Test
{
    [TestFixture]
    public class TestFlow :TestBase
    {
        //测试流程需要模拟登录用户
        public override ServiceCollection GetService()
        {
            var services = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest")).Returns(new UserAuthSession { Account = "admin" });
            services.AddScoped(x => cachemock.Object);

            //模拟服务端httpContext
            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("tokentest");
            services.AddScoped(x => httpContextAccessorMock.Object);

            //模拟httpclientfactory
            var mockHttpFac = new Mock<IHttpClientFactory>();
            services.AddScoped(x => mockHttpFac.Object);

            return services;
        }
        
        [Test]
        public void Create()
        {
            var options = new IdGeneratorOptions(){ WorkerId = 1};
            IIdGenerator idHelper = new YitIdGenerator(options);
            var code  =  idHelper.NewLong().ToString();
            
            var app = _autofacServiceProvider.GetService<FlowInstanceApp>();
            app.CreateInstance(new AddFlowInstanceReq
            {
               SchemeId = "18a34903-175b-4cfb-9947-db67b538bbc8",
               FrmType = 2,
               FrmData = "{\"WorkDate\":\"2021-03-15\",\"Time\":\"8\",\"Reason\":\"dsdsds\"}",
               CustomName = DateTime.Now.ToString(),
               Code = code
            });
        }


        [Test]
        public void Verificate()
        {
            var app = _autofacServiceProvider.GetService<FlowInstanceApp>();
            app.Verification(new VerificationReq
            {
                FlowInstanceId = "c2d6d4b9-527d-426e-98db-1d5dc905a994",
                VerificationFinally = "3"
            });
        }
    }
}
