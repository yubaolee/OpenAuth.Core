﻿using System;
using System.IO;
using System.Linq;
using System.Reflection;
using Autofac;
using Autofac.Extensions.DependencyInjection;
using Infrastructure;
using Infrastructure.Utilities;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
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
            //读取OpenAuth.WebApi的配置文件用于单元测试
            var path = AppContext.BaseDirectory;
            int pos = path.IndexOf("OpenAuth.Repository");
            var basepath = Path.Combine(path.Substring(0,pos) ,"OpenAuth.WebApi");
            IConfiguration config = new ConfigurationBuilder()
                .SetBasePath(basepath)
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .AddJsonFile("appsettings.Development.json", optional: true)
                .AddEnvironmentVariables()
                .Build();
         
            //添加log4net
            serviceCollection.AddLogging(builder =>
            {
                builder.ClearProviders(); //去掉默认的日志
                builder.AddConfiguration(config.GetSection("Logging"));  //读取配置文件中的Logging配置
            });
            //注入OpenAuth.WebApi配置文件
            serviceCollection.AddScoped(x => config);
            

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("tokentest");
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TENANT_ID]).Returns("OpenAuthDBContext");

            serviceCollection.AddScoped(x => httpContextAccessorMock.Object);

            serviceCollection.AddDbContext<OpenAuthDBContext>();

            var builder = new ContainerBuilder();

            //注册repository层
            builder.RegisterAssemblyTypes(Assembly.GetExecutingAssembly());

            builder.Populate(serviceCollection);
          
            var _container = builder.Build();
            _autofacServiceProvider = new AutofacServiceProvider(_container);
            
            var dbtypes = config.GetSection("AppSetting:DbTypes").GetChildren()
                .ToDictionary(x => x.Key, x => x.Value);
            
            Console.WriteLine($"单元测试数据库信息:{dbtypes[httpContextAccessorMock.Object.GetTenantId()]}/{config.GetSection("ConnectionStrings")["OpenAuthDBContext"]}");


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
