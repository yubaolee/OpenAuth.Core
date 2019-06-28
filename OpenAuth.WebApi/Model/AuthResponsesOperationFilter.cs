using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Options;
using OpenAuth.App;
using Swashbuckle.AspNetCore.Swagger;
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

        public void Apply(Operation operation, OperationFilterContext context)
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
                //operation.Responses.Add("401", new Response { Description = "暂无访问权限" });
                //operation.Responses.Add("403", new Response { Description = "禁止访问" });
                operation.Security = new List<IDictionary<string, IEnumerable<string>>>
                {
                    new Dictionary<string, IEnumerable<string>> {{"oauth2", new[] { "openauthapi" } }}
                };
            }
        }
    }
}
