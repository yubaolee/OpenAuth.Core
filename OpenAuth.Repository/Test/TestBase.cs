using System.Reflection;
using Autofac;
using Autofac.Extensions.DependencyInjection;
using Infrastructure;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Moq;
using NUnit.Framework;
using OpenAuth.Repository.Interface;

namespace OpenAuth.Repository.Test
{
    /// <summary>
    /// Repository测试基类
    /// 测试用于测试DbContext、UnitWork、Repository，如果需要测试业务逻辑，请使用OpenAuth.App里面的单元测试
    /// </summary>
    public class TestBase
    {
        protected AutofacServiceProvider _autofacServiceProvider;

        [SetUp]
        public void Init()
        {
            var serviceCollection = GetService();
            serviceCollection.AddMemoryCache();
            serviceCollection.AddOptions();
            serviceCollection.AddLogging();
            serviceCollection.AddScoped(typeof(IRepository<,>), typeof(BaseRepository<,>));
            serviceCollection.AddScoped(typeof(IUnitWork<>), typeof(UnitWork<>));

            //模拟配置文件
            var optionMock = new Mock<IOptions<AppSetting>>();
            optionMock.Setup(x => x.Value).Returns(new AppSetting { DbType = Define.DBTYPE_MYSQL });
            serviceCollection.AddScoped(x => optionMock.Object);

            //模拟多租户id
            var configMock = new Mock<IConfiguration>();
            configMock.Setup(x => x.GetSection("ConnectionStrings")[Define.TENANT_ID]).Returns("");
            serviceCollection.AddScoped(x => configMock.Object);

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("tokentest");
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TENANT_ID]).Returns("OpenAuthDBContext");

            serviceCollection.AddScoped(x => httpContextAccessorMock.Object);

            serviceCollection.AddDbContext<OpenAuthDBContext>(options =>
                options.UseSqlServer("Data Source=.;Initial Catalog=OpenAuthDB;User=sa;Password=000000;Integrated Security=True"));

            var builder = new ContainerBuilder();

            //注册repository层
            builder.RegisterAssemblyTypes(Assembly.GetExecutingAssembly());

            builder.Populate(serviceCollection);
          
            var _container = builder.Build();
            _autofacServiceProvider = new AutofacServiceProvider(_container);

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
