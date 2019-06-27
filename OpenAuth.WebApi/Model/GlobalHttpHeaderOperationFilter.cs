// <copyright file="GlobalHttpHeaderOperationFilter.cs" company="openauth.me">
// Copyright (c) 2019 openauth.me. All rights reserved.
// </copyright>
// <author>www.cnblogs.com/yubaolee</author>
// <date>2019-01-05</date>
// <summary>在swagger界面加上http header</summary>

using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Options;
using OpenAuth.App;
using OpenAuth.App.Model;
using Swashbuckle.AspNetCore.Swagger;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace OpenAuth.WebApi.Model
{
    public class GlobalHttpHeaderOperationFilter : IOperationFilter
    {
        private IOptions<AppSetting> _appConfiguration;

        public GlobalHttpHeaderOperationFilter(IOptions<AppSetting> appConfiguration)
        {
            _appConfiguration = appConfiguration;
        }

        public void Apply(Operation operation, OperationFilterContext context)
        {
            //如果是Identity认证方式，不需要界面添加x-token得输入框
            if (_appConfiguration.Value.IsIdentityAuth)
                return;

            if (operation.Parameters == null)
            {
                operation.Parameters = new List<IParameter>();
            }

            var actionAttrs = context.ApiDescription.ActionAttributes();
            var isAnony = actionAttrs.Any(a => a.GetType() == typeof(AllowAnonymousAttribute));

            //不是匿名，则添加默认的X-Token
            if (!isAnony)
            {
                operation.Parameters.Add(new NonBodyParameter()
                {
                    Name = "X-Token",  
                    In = "header",
                    Type = "string",
                    Description = "当前登录用户登录token",
                    Required = false
                });
            }
        }
    }
}
