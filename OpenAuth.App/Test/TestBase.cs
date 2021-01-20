using Autofac.Extensions.DependencyInjection;
using Infrastructure;
using Infrastructure.Cache;
using Infrastructure.Extensions.AutofacManager;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Moq;
using NUnit.Framework;
using OpenAuth.App.SSO;
using OpenAuth.Repository;

namespace OpenAuth.App.Test
{
    public class TestBase
    {
        protected AutofacServiceProvider _autofacServiceProvider;

        [SetUp]
        public void Init()
        {
            var serviceCollection = GetService();
            serviceCollection.AddMemoryCache();
            serviceCollection.AddOptions();
            serviceCollection.AddLogging(builder =>
            {
                builder.ClearProviders(); //去掉默认的日志
                builder.AddLog4Net();
            });
            
            //模拟配置文件
            var optionMock = new Mock<IOptions<AppSetting>>();
            optionMock.Setup(x => x.Value).Returns(new AppSetting { DbType = Define.DBTYPE_MYSQL});
            serviceCollection.AddScoped(x => optionMock.Object);

            //模拟多租户id
            var configMock = new Mock<IConfiguration>();
            configMock.Setup(x => x.GetSection("ConnectionStrings")[Define.TENANT_ID]).Returns("");
            serviceCollection.AddScoped(x => configMock.Object);

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("tokentest");
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TENANT_ID]).Returns("OpenAuthDBContext");

            serviceCollection.AddScoped(x => httpContextAccessorMock.Object);

            // 测试my sql
            serviceCollection.AddDbContext<OpenAuthDBContext>(options =>
               options.UseMySql("server=127.0.0.1;user id=root;database=openauthdb;password=000000"));

//            serviceCollection.AddDbContext<OpenAuthDBContext>(options =>
//                options.UseSqlServer("Data Source=.;Initial Catalog=OpenAuthDB;User=sa;Password=000000;Integrated Security=True"));

            var container = AutofacExt.InitForTest(serviceCollection);
            _autofacServiceProvider = new AutofacServiceProvider(container);
            AutofacContainerModule.ConfigServiceProvider(_autofacServiceProvider);
        }

        /// <summary>
        /// 测试框架默认只注入了缓存Cache，配置Option；
        /// 如果在测试的过程中需要模拟登录用户，cookie等信息，需要重写该方法，可以参考TestFlow的写法
        /// </summary>
        public virtual ServiceCollection GetService()
        {
            return  new ServiceCollection();
        }
    }
}
