using Microsoft.AspNetCore.Builder;

namespace Infrastructure.Middleware
{
    /// <summary>
    /// 
    /// </summary>
    public static class ApplicationBuilderExtension
    {
        /// <summary>
        /// 注入日志中间件
        /// </summary>
        /// <param name="builder"></param>
        /// <returns></returns>
        public static IApplicationBuilder UseLogMiddleware(this IApplicationBuilder builder)
        {
            return builder.UseMiddleware<RequestResponseLoggingMiddleware>();
        }
    }
}