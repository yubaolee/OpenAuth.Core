namespace Infrastructure.Extensions.AutofacManager
{
    /// <summary>
    /// 提供全局静态获取服务的能力。
    /// <para>例：AutofacContainerModule.GetService<IPathProvider>()</para>
    /// </summary>
    public class AutofacContainerModule
    {
        public static TService GetService<TService>() where TService:class
        {
            return typeof(TService).GetService() as TService;
        }
    }
}
