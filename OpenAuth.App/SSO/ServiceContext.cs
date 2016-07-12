using System;
using System.Globalization;
using Infrastructure.Cache;

namespace OpenAuth.App.SSO
{
    public abstract class ServiceContext : IDisposable
    {
        /// <summary>
        /// 缓存组件
        /// </summary>
        public CacheContext CacheContext { get; private set; }

        /// <summary>
        /// 动态设置缓存对象的新实例
        /// </summary>
        /// <param name="cacheContext">缓存实例对象</param>
        public void SetCacheInstance(CacheContext cacheContext)
        {
            //先释放现有的缓存组件
            if (CacheContext != null)
            {
                CacheContext = null;
            }

            //初始化缓存组件新的实例
            CacheContext = cacheContext;
        }

        public void SetCacheInstance(Type cacheContextType)
        {
            if (cacheContextType == null)
            {
                throw new ArgumentNullException("cacheContextType");
            }

            if (!typeof(CacheContext).IsAssignableFrom(cacheContextType))
            {
                throw new ArgumentException(
                    string.Format(CultureInfo.CurrentCulture, "该类型 {0} 必须继承自抽象类CacheContext", cacheContextType),
                    "cacheContextType");
            }

            try
            {
                CacheContext = Activator.CreateInstance(cacheContextType) as CacheContext;
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException(
                        String.Format(
                            CultureInfo.CurrentCulture,
                            "创建抽象类 CacheContext 的实例 {0} 失败",
                            cacheContextType),
                        ex);
            }
        }

        public void Dispose()
        {

        }
    }
}
