using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Options;
using Microsoft.OpenApi.Models;
using OpenAuth.App;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace OpenAuth.WebApi.Model
{
    /// <summary>
    /// swagger请求的时候，如果是Identity方式，自动加授权方式
    /// </summary>
    public class AuthResponsesOperationFilter : IOperationFilter
    {
        private IOptions<AppSetting> _appConfiguration;

        public AuthResponsesOperationFilter(IOptions<AppSetting> appConfiguration)
        {
            _appConfiguration = appConfiguration;
        }

        public void Apply(OpenApiOperation operation, OperationFilterContext context)
        {
            if (!_appConfiguration.Value.IsIdentityAuth)
            {
                return;
            }

            var anonymous = context.MethodInfo.DeclaringType.GetCustomAttributes(true)
                .Union(context.MethodInfo.GetCustomAttributes(true))
                .OfType<AllowAnonymousAttribute>().Any();
            if (!anonymous)
            {
                var security = new List<OpenApiSecurityRequirement>();
                security.Add(new OpenApiSecurityRequirement {
                    {
                        new OpenApiSecurityScheme
                        {
                            Reference = new OpenApiReference
                            {
                                Type = ReferenceType.SecurityScheme,
                                Id = "oauth2"
                            }
                        },
                        new[] { "openauthapi" }
                    }
                });
                operation.Security = security;
//                operation.Security = new List<OpenApiSecurityRequirement>
//                {
//                    new Dictionary<string, IEnumerable<string>> {{"oauth2", new[] { "openauthapi" } }}
//                };
            }
        }
    }
}
