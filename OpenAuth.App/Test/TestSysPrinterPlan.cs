using System;
using System.Threading;
using System.Threading.Tasks;
using Infrastructure;
using Infrastructure.Cache;
using Infrastructure.Extensions;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using NUnit.Framework;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App.Test
{
    public class TestSysPrinterPlan : TestBase
    {
        public override ServiceCollection GetService()
        {
            var services = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest"))
                .Returns(new UserAuthSession { Account = Define.SYSTEM_USERNAME });
            services.AddScoped(x => cachemock.Object);

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME])
                .Returns("tokentest");

            services.AddScoped(x => httpContextAccessorMock.Object);

            return services;
        }

        [Test]
        public async Task QueryWithParam()
        {
            var app = _autofacServiceProvider.GetService<SysPrinterPlanApp>();

            var result = await app.Query(new QueryReq()
            {
                SourceSql = "select * from user where account like @account",
                ParamJsonStr = "{\"account\":\"test%\"}",
                page = 1,
                limit = 2
            });

            Console.WriteLine(JsonHelper.Instance.Serialize(result));

            //异步测试，延长主线程，防止程序退出
            Thread.Sleep(1000);
        }
        
        [Test]
        public async Task QueryNoParam()
        {
            var app = _autofacServiceProvider.GetService<SysPrinterPlanApp>();

            var result = await app.Query(new QueryReq()
            {
                SourceSql = "select * from user ",
                page = 1,
                limit = 2
            });

            Console.WriteLine(JsonHelper.Instance.Serialize(result));

            //异步测试，延长主线程，防止程序退出
            Thread.Sleep(1000);
        }
        
    }
}
