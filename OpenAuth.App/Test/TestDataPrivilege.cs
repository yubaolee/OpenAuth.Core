using System;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using NUnit.Framework;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;

namespace OpenAuth.App.Test
{
    class TestDataPrivilege :TestBase
    {
        public override ServiceCollection GetService()  
        {
            var services = new ServiceCollection();

            var cachemock = new Mock<ICacheContext>();
            cachemock.Setup(x => x.Get<UserAuthSession>("tokentest")).Returns(new UserAuthSession { Account = "Systems" });
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
            //该测试解析为：针对资源列表，【管理员】可以看到所有，角色为【神】或【测试】的只能看到自己创建的
            var filterGroup = new FilterGroup
            {
                Operation = "or"
            };
            filterGroup.Filters = new[]
            {
                new Filter  //角色为【管理员】的，可以看到所有
                {
                    Key = "{loginRole}",
                    Contrast = "contains",
                    Value = "09ee2ffa-7463-4938-ae0b-1cb4e80c7c13" //管理员
                }
            };
            filterGroup.Children = new[]
            {
                new FilterGroup   //登录用户角色包含【测试】或包含【神】的，只能看到自己的
                {
                    Operation = "and",
                    Filters = new Filter[]
                    {
                        new Filter
                        {
                            Key = "CreateUserId",
                            Contrast = "==",
                            Value = "{loginUser}",
                            Text = "{当前登录用户}"
                        },
                        new Filter
                        {
                            Key = "{loginRole}",
                            Contrast = "intersect",
                            Value = "0a7ebd0c-78d6-4fbc-8fbe-6fc25c3a932d,77e6d0c3-f9e1-4933-92c3-c1c6eef75593" //测试,神
                        }
                    }
                }
            };
            
            app.Clear();
            app.Add(new AddOrUpdateDataPriviReq
            {
                SourceCode = "Resource",
                Description = "资源数据规则",
                PrivilegeRules = JsonHelper.Instance.Serialize(filterGroup)
            });
            Console.WriteLine(JsonHelper.Instance.Serialize(filterGroup));
        }
    }
}
