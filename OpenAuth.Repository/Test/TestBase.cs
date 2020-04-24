using System.Reflection;
using Autofac;
using Autofac.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using NUnit.Framework;
using OpenAuth.Repository.Interface;

namespace OpenAuth.Repository.Test
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
            serviceCollection.AddScoped(typeof(IRepository<>), typeof(BaseRepository<>));

            serviceCollection.AddDbContext<OpenAuthDBContext>(options =>
                options.UseSqlServer("Data Source=.;Initial Catalog=OpenAuthDB;User=sa;Password=000000;Integrated Security=True"));

            var builder = new ContainerBuilder();

            //注册repository层
            builder.RegisterAssemblyTypes(Assembly.GetExecutingAssembly());

            //   builder.RegisterGeneric(typeof(BaseRepository<>)).As(typeof(IRepository<>)).PropertiesAutowired();
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
