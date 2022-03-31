using System;
using System.Net.Http;
using System.Net.Http.Headers;
using Autofac;
using Infrastructure;
using Microsoft.AspNetCore.TestHost;
using Microsoft.Extensions.DependencyInjection;
using NUnit.Framework;
using OpenAuth.App;
using OpenAuth.App.SSO;

namespace OpenAuth.WebApi.Test
{
    /// <summary>
    /// 模拟HTTP请求测试
    /// 用于测试模型绑定，看看一次客户端的请求是否能被正确解析，亦或者测试WebAPI入口的一些Filter AOP等是否被正确触发。
    /// 详情参考：https://www.cnblogs.com/yubaolee/p/DotNetCoreUnitTest.html
    /// </summary>
    public class TestHttpRequest
    {
        private HttpClient _client;

        void ConfigureTestServices(IServiceCollection services)
        {
        }

        void ConfigureTestContainer(ContainerBuilder builder)
        {
            AutofacExt.InitAutofac(builder);
        }

        [SetUp]
        public void Init()
        {
            var factory = new AutofacWebApplicationFactory<Startup>();

            _client = factory
                .WithWebHostBuilder(builder => {
                    builder.ConfigureTestServices(ConfigureTestServices);
                    builder.ConfigureTestContainer<ContainerBuilder>(ConfigureTestContainer);
                })
                .CreateClient();
        }
        /// <summary>
        /// 模拟一次登录
        /// </summary>
        [Test]
        public LoginResult TestLogin()
        {
            var loginreq = new PassportLoginRequest
            {
                Account = "System",
                Password = "123456",
                AppKey = "openauth"
            };

            var request = new StringContent(JsonHelper.Instance.Serialize(loginreq));
            request.Headers.ContentType = MediaTypeHeaderValue.Parse("application/json");
            var response = _client.PostAsync("http://localhost:52789/api/Check/Login", request);

            string result = response.Result.Content.ReadAsStringAsync().Result;
            var loginresult = JsonHelper.Instance.Deserialize<LoginResult>(result);
            
            Console.WriteLine($"登录结果:{result}");
            return loginresult;
        }
        /// <summary>
        /// 模拟加载字典列表
        /// </summary>
        [Test]
        public void TestLoad()
        {
            _client.DefaultRequestHeaders.Add("X-Token", TestLogin().Token);
            var response = _client.GetAsync("http://localhost:52789/api/categorys/load?page=1&limit=20");

            string result = response.Result.Content.ReadAsStringAsync().Result;
            Console.WriteLine($"获取分类列表:{result}");
        }
    }
}