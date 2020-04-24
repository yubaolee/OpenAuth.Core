using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using OpenAuth.App.SSO;

namespace OpenAuth.App.Test
{
    public class TestFrmLeaveReq : TestBase
    {
        //测试流程需要模拟登录用户
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
        public void Add()
        {
            var frm =
                "{\"id\":\"\",\"userName\":\"111111111\",\"requestType\":\"\",\"startDate\":\"2019-03-05T16:00:00.000Z\",\"startTime\":\"2019-03-19T08:01:23.000Z\",\"endDate\":\"2019-03-27T16:00:00.000Z\",\"endTime\":\"2019-03-19T08:01:26.000Z\",\"requestComment\":\"2222222222222\",\"attachment\":\"\",\"createDate\":\"2019-03-19T08:01:26.000Z\",\"createUserId\":\"\",\"createUserName\":\"\",\"extendInfo\":\"\"}";
            var app = _autofacServiceProvider.GetService<FrmLeaveReqApp>();
            app.Add("d8fa445f-edd9-4604-8d9e-b17ba921f9dd",
              frm);
        }
    }
}
