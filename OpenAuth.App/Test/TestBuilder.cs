using System.IO;
using System.Net.Http;
using System.Reflection;
using Infrastructure.Cache;
using Infrastructure.Provider;
using Microsoft.AspNetCore.Http;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Hosting;
using Moq;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;
using HttpContext = Infrastructure.Utilities.HttpContext;

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

            //模拟路径
            var path = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location)
                .Replace("\\OpenAuth.App\\bin\\Debug\\netcoreapp3.1","");
            var mockPathProvider = new Mock<IPathProvider>();
            mockPathProvider.Setup(x => x.MapPath("",false)).Returns(path);
            services.AddScoped(x => mockHttpFac.Object);
            
            var host = new Mock<IHostEnvironment>();
            host.Setup(x => x.ContentRootPath).Returns(Path.Combine(path, "OpenAuth.WebApi"));
            services.AddScoped(x => host.Object);
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
            // var id = app.Add(new AddOrUpdateBuilderTableReq()
            // {
            //     TableName = "application",
            //     Comment = "这是一个普通的应用管理生成模版",
            //     ClassName = "Application",
            //     Folder = "Application",
            //     ModuleCode = "Application",
            //     ModuleName = "模块管理"
            // });
            
            app.CreateEntity(new CreateEntityReq
            {
                Id = "f4464610-8c5c-441f-8825-13d6073e4385"
            });
        }

        [Test]
        public void CheckModule()
        {
            var app = _autofacServiceProvider.GetService<BuilderTableApp>();
            app.CheckExistsModule("Application");
        }
        
        [Test]
        public void CreateBusiness()
        {
            var app = _autofacServiceProvider.GetService<BuilderTableApp>();
            
            app.CreateBusiness(new CreateBusiReq
            {
                Id = "f4464610-8c5c-441f-8825-13d6073e4385"
            });
        }
        
        [Test]
        public void CreateVue()
        {
            var app = _autofacServiceProvider.GetService<BuilderTableApp>();
            
            app.CreateVue(new CreateVueReq()
            {
                Id = "f4464610-8c5c-441f-8825-13d6073e4385",
                VueProjRootPath = "D:\\OpenAuth.Pro\\Client"
            });
            app.CreateVueApi(new CreateVueReq()
            {
                Id = "f4464610-8c5c-441f-8825-13d6073e4385",
                VueProjRootPath = "D:\\OpenAuth.Pro\\Client"
            });
        }
    }
}
