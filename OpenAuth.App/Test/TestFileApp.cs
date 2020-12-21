using System;
using System.Threading.Tasks;
using Castle.Core.Logging;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Moq;
using NUnit.Framework;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;

namespace OpenAuth.App.Test
{
    class TestFileApp :TestBase
    {
        public override ServiceCollection GetService()
        {
            var services = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest")).Returns(new UserAuthSession { Account = Define.SYSTEM_USERNAME });
            services.AddScoped(x => cachemock.Object);

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("tokentest");
            
           services.AddScoped(x => httpContextAccessorMock.Object);

           var logMock = new Mock<ILogger<FileApp>>();
           services.AddScoped(x => logMock.Object);
           
            return services;
        }
        
        
        [Test]
        public void TestLoad()
        {
            var app = _autofacServiceProvider.GetService<FileApp>();
            var result = app.Load(new QueryFileListReq()
            {
                page = 1,
                limit = 10
            });
            
            Console.WriteLine(JsonHelper.Instance.Serialize(result.Result));
        }
        
    }
}
