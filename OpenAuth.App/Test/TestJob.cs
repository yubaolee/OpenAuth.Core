﻿using System;
using System.Threading;
using Infrastructure;
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
    public class TestJob :TestBase
    {
        public override ServiceCollection GetService()
        {
            var services = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest")).Returns(new UserAuthSession { Account = "admin" });
            services.AddScoped(x => cachemock.Object);

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("tokentest");

            services.AddScoped(x => httpContextAccessorMock.Object);

            return services;
        }


        [Test]
        public void GetSysJobs()
        {
            var app = _autofacServiceProvider.GetService<OpenJobApp>();
            var result = app.QueryLocalHandlers();
            Console.WriteLine(JsonHelper.Instance.Serialize(result));
        }

        [Test]
        public void ChangeStatus()
        {
            var app = _autofacServiceProvider.GetService<OpenJobApp>();
            app.ChangeJobStatus(new ChangeJobStatusReq
            {
                Id = "f40fe48d-71a4-4f47-b324-6178d97abfb9",
                Status = 1
            });
            Thread.Sleep(60000);
        }
    }
}
