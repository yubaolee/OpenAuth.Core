using System.Net.Http;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;

namespace OpenAuth.App.Test
{
    [TestFixture]
    public class TestBuilder :TestBase
    {
        //测试流程需要模拟登录用户
        public override ServiceCollection GetService()
        {
            var services = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest")).Returns(new UserAuthSession { Account = "test3" });
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
        public void add()
        {
            var app = _autofacServiceProvider.GetService<BuilderTableApp>();
            app.Add(new AddOrUpdateBuilderTableReq()
            {
               TableName = "application",
               Comment = "这是一个普通的应用管理生成模版",
               ClassName = "Application",
               ModuleCode = "Application",
               ModuleName = "模块管理"
            });
        }

        [Test]
        public void CreateEntity()
        {
            var app = _autofacServiceProvider.GetService<BuilderTableApp>();
            var id = app.Add(new AddOrUpdateBuilderTableReq()
            {
                TableName = "application",
                Comment = "这是一个普通的应用管理生成模版",
                ClassName = "Application",
                Folder = "Application",
                ModuleCode = "Application",
                ModuleName = "模块管理"
            });
            
            app.CreateEntity(new CreateEntityReq
            {
                Id = id
            });
        }
    }
}
