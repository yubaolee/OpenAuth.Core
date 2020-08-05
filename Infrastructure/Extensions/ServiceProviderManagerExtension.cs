using System;

namespace Infrastructure.Extensions
{
    public static class ServiceProviderManagerExtension
    {
        public static object GetService(this Type serviceType)
        {
            return Utilities.HttpContext.Current.RequestServices.GetService(serviceType);
        }

    }
}
