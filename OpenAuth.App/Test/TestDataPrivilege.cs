using System;
using System.Collections.Generic;
using System.Text;
using Autofac.Extensions.DependencyInjection;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using NUnit.Framework;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Test
{
    class TestDataPrivilege :TestBase
    {
        public override ServiceCollection GetService()  
        {
            var services = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest")).Returns(new UserAuthSession { Account = "System" });
            services.AddScoped(x => cachemock.Object);

            var httpContextAccessorMock = new Mock<IHttpContextAccessor>();
            httpContextAccessorMock.Setup(x => x.HttpContext.Request.Query[Define.TOKEN_NAME]).Returns("tokentest");

            services.AddScoped(x => httpContextAccessorMock.Object);

            return services;
        }

        /// <summary>
        /// 测试资源列表的权限控制
        /// </summary>
        [Test]
        public void LoadData()
        {
            var app = _autofacServiceProvider.GetService<ResourceApp>();
            var result = app.Load(new QueryResourcesReq());
            Console.WriteLine(JsonHelper.Instance.Serialize(result));
        }
        
        [Test]
        public void TestAdd()
        {
            var auth = _autofacServiceProvider.GetService<IAuth>();
            var app = _autofacServiceProvider.GetService<DataPrivilegeRuleApp>();
            var filterGroup = new FilterGroup
            {
                Operation = "or"
            };
            filterGroup.Filters = new[]
            {
                new Filter
                {
                    Key = "AppId",
                    Contrast = "==",
                    Value = "110"
                },
                new Filter
                {
                    Key = "Name",
                    Contrast = "==",
                    Value = "登陆"
                }
            };
            filterGroup.Children = new[]
            {
                new FilterGroup
                {
                    Operation = "and",
                    Filters = new Filter[]
                    {
                        new Filter
                        {
                            Key = "Name",
                            Contrast = "==",
                            Value = "注销账号"
                        },
                        new Filter
                        {
                            Key = "AppId",
                            Contrast = "==",
                            Value = "119"
                        }
                    }
                }
            };
            
            app.Add(new AddOrUpdateDataPriviReq
            {
                SourceCode = "Resource",
                Description = "资源数据规则",
                PrivilegeRules = JsonHelper.Instance.Serialize(filterGroup)
            });
        }
    }
}
