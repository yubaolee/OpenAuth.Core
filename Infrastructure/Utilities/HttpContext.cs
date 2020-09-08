using Infrastructure.Extensions.AutofacManager;
using Microsoft.AspNetCore.Http;

namespace Infrastructure.Utilities
{
    public static class HttpContext
    {
        private static IHttpContextAccessor _accessor=AutofacContainerModule.GetService<IHttpContextAccessor>();

        public static Microsoft.AspNetCore.Http.HttpContext Current => _accessor.HttpContext;
        
    }
}
