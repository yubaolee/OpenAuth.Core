// <copyright file="GlobalHttpHeaderOperationFilter.cs" company="openauth.me">
// Copyright (c) 2019 openauth.me. All rights reserved.
// </copyright>
// <author>www.cnblogs.com/yubaolee</author>
// <date>2019-01-05</date>
// <summary>在swagger界面加上http header</summary>

using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Authorization;
using OpenAuth.App.Model;
using Swashbuckle.AspNetCore.Swagger;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace OpenAuth.WebApi.Model
{
    public class GlobalHttpHeaderOperationFilter : IOperationFilter
    {
        public void Apply(Operation operation, OperationFilterContext context)
        {
            if (operation.Parameters == null)
            {
                operation.Parameters = new List<IParameter>();
            }

            var actionAttrs = context.ApiDescription.ActionAttributes();

            var isIdentityAuth = actionAttrs.Any(a => a.GetType() == typeof(AuthorizeAttribute));
            var isAnony = actionAttrs.Any(a => a.GetType() == typeof(AllowAnonymousAttribute));

            //不是匿名或Identity授权，则添加默认的X-Token
            if (!(isAnony || isIdentityAuth))
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
