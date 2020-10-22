using Infrastructure.Extensions.AutofacManager;
using Infrastructure.Provider;

namespace Infrastructure.Extensions
{
    public static class ServerExtension
    {
        /// <summary>
        /// 返回的路径后面不带/，拼接时需要自己加上/
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static string MapPath(this string path)
        {
            return MapPath(path, false);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="path"></param>
        /// <param name="rootPath">获取wwwroot路径</param>
        /// <returns></returns>
        public static string MapPath(this string path,bool rootPath)
        {
            return AutofacContainerModule.GetService<IPathProvider>().MapPath(path,rootPath);
        }
    }
}
