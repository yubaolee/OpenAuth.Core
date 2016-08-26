using Autofac;
using Autofac.Core;
using System.Web.Mvc;

namespace Infrastructure
{
    /// <summary>
    /// 依赖注入
    /// </summary>
    public class DIContainer
    {
        private static IContainer iContainer;
        public static void RegisterContainer(IContainer container)
        {
            iContainer = container;
        }
        /// <summary>
        /// 按类型获取组件
        /// </summary>
        /// <typeparam name="Tservice"></typeparam>
        /// <returns></returns>
        public static Tservice Resolve<Tservice>()
        {
            return ResolutionExtensions.Resolve<Tservice>(iContainer);
        }
        /// <summary>
        /// 按参数获取组件
        /// </summary>
        /// <typeparam name="Tservice"></typeparam>
        /// <param name="paramters"></param>
        /// <returns></returns>
        public static Tservice Resolve<Tservice>(params Parameter[] parameters)
        {
            return ResolutionExtensions.Resolve<Tservice>(iContainer, parameters);
        }
        /// <summary>
        /// 按key获取组件
        /// </summary>
        /// <typeparam name="Tservice">组件类型</typeparam>
        /// <param name="serviceKey">枚举类型的key</param>
        /// <returns>返回获取的组件</returns>
        public static Tservice ResolveKeyed<Tservice>(object serviceKey)
        {
            return ResolutionExtensions.ResolveKeyed<Tservice>(iContainer, serviceKey);
        }
        /// <summary>
        /// 按名称获取组件
        /// </summary>
        /// <typeparam name="Tservice"></typeparam>
        /// <param name="serviceName"></param>
        /// <returns></returns>
        public static Tservice ResolveNamed<Tservice>(string serviceName)
        {
            return ResolutionExtensions.ResolveNamed<Tservice>(iContainer, serviceName);
        }
        /// <summary>
        /// 获取InstancePerHttpRequest的组件 mvc
        /// </summary>
        /// <typeparam name="Tservice"></typeparam>
        /// <returns></returns>
        public static Tservice ResolvePerHttpRequest<Tservice>()
        {
            IDependencyResolver current = DependencyResolver.Current;
            if (current != null)
            {
                Tservice service = (Tservice)current.GetService(typeof(Tservice));
                if (service != null)
                {
                    return service;
                }
            }
            return ResolutionExtensions.Resolve<Tservice>(iContainer);
        }
    }
}
