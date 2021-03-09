using System;
using System.Linq;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Test
{
    public class TestCache :TestBase
    {
        public override ServiceCollection GetService()
        {
            var services = new ServiceCollection();

            var delservices = services.Where(u => u.ServiceType == typeof(ICacheContext)).ToList();
            for (int i = 0; i < delservices.Count(); i++)
            {
                services.Remove(delservices[i]);
            }
            services.AddScoped(typeof(ICacheContext), typeof(RedisCacheContext));

            return services;
        }


        [Test]
        public void SetAndGet()
        {
            var app = _autofacServiceProvider.GetService<ICacheContext>();
            app.Set("yubaolee", "ok", DateTime.Now.AddDays(1));

            var result = app.Get<string>("yubaolee");
            Console.WriteLine($"redis结果:{result}");
        }


    }
}
