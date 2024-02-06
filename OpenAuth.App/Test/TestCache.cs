﻿using System;
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


        /// <summary>
        /// 测试字符串
        /// </summary>
        [Test]
        public void SetString()
        {
            var app = _autofacServiceProvider.GetService<ICacheContext>();
            app.Set("yubaolee", "ok", DateTime.Now.AddDays(1));

            var result = app.Get<string>("yubaolee");
            Console.WriteLine($"redis结果:{result}");
        }
        
        /// <summary>
        /// 测试对象
        /// </summary>
        [Test]
        public void SetObj()
        {
            var app = _autofacServiceProvider.GetService<ICacheContext>();
            app.Set("user:info", new User
            {
                Name = "测试",
                Account ="Test",
                BizCode = "0.1.1"
            }, DateTime.Now.AddDays(1));

            var result = app.Get<User>("user:info");
            Console.WriteLine($"redis结果:{JsonHelper.Instance.Serialize(result)}");
        }
        
        /// <summary>
        /// 测试获取不存在的key
        /// </summary>
        [Test]
        public void GetNoExistKey()
        {
            var app = _autofacServiceProvider.GetService<ICacheContext>();
           
            var result = app.Get<User>("noexistkey");
            Console.WriteLine($"redis结果:{JsonHelper.Instance.Serialize(result)}");
        }


    }
}
