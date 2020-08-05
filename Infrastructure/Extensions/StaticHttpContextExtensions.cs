using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure.Extensions
{
    /// <summary>
    /// 启用静态全局变量后续可以使用HttpContext.Current访问
    /// <para>需要在Startup.cs中调用UseStaticHttpContext()进行初始化</para>
    /// </summary>
    public static class StaticHttpContextExtensions
    {
        /// <summary>
        /// 配置httpContext，后续可以使用HttpContext.Current访问
        /// </summary>
        /// <param name="app"></param>
        /// <returns></returns>
        public static IApplicationBuilder UseStaticHttpContext(this IApplicationBuilder app)
        {
            var httpContextAccessor = app.ApplicationServices.GetRequiredService<IHttpContextAccessor>();
            Utilities.HttpContext.Configure(httpContextAccessor);
            return app;
        }
    }

}
