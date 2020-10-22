using System;

namespace Infrastructure.Extensions.AutofacManager
{
    /// <summary>
    /// 提供全局静态获取服务的能力。
    /// <para>例：AutofacContainerModule.GetService<IPathProvider>()</para>
    /// </summary>
    public class AutofacContainerModule
    {
        static private IServiceProvider _provider;
        public static void ConfigServiceProvider(IServiceProvider serviceProvider)
        {
            _provider = serviceProvider;
        }
        public static TService GetService<TService>() where TService:class
        {
            Type typeParameterType = typeof(TService);
            return (TService)_provider.GetService(typeParameterType);
        }
    }
}
