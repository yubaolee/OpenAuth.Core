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
            // 全局初始化设置WorkerId，默认最大2^16-1。（初始化过程全局只需一次，且必须最先设置）
            var options = new IdGeneratorOptions()
            {
                Method = 1,
                WorkerId = 1
            };
            
            YitIdHelper.SetIdGenerator(options);
            var code = YitIdHelper.NextId().ToString();
            
            var app = _autofacServiceProvider.GetService<FlowInstanceApp>();
            var instanceReq = new AddFlowInstanceReq
            {
                SchemeId = "0dac17c2-fec7-4bcd-a391-4ff74de8506a",
                FrmType = 1,
                DbName = "FrmLeaveReq",
                FrmData = "{\"id\":\"\",\"userName\":\"周翔宇\",\"requestType\":\"病假\",\"startDate\":\"2021-03-08T16:00:00.000Z\",\"startTime\":\"2021-03-16T15:11:28.000Z\",\"endDate\":\"2021-03-24T16:00:00.000Z\",\"endTime\":\"2021-03-16T15:11:31.000Z\",\"requestComment\":\"1111\",\"attachment\":\"\",\"files\":[],\"extendInfo\":\"\"}",
                CustomName = DateTime.Now.ToString(),
                Code = code
            };
            app.CreateInstance(instanceReq);
            
        }

        [Test]
        public void GetDetail()
        {
            var app = _autofacServiceProvider.GetService<FlowInstanceApp>();
            var flowinstance = app.GetForVerification("80e9db5f-419b-4b65-a274-abe2660608dd");
            Console.WriteLine(JsonHelper.Instance.Serialize(flowinstance));

        }


        [Test]
        public void Verificate()
        {
            var app = _autofacServiceProvider.GetService<FlowInstanceApp>();
            app.Verification(new VerificationReq
            {
                FlowInstanceId = "12a99820-3762-40a7-9f0f-ad0f8a0aab2d",
                VerificationFinally = "3"
            });
        }
    }
}
