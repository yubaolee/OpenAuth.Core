using System;
using System.Globalization;

namespace Infrastructure.Cache
{
    /// <summary>
    /// 缓存工厂
    /// <para>李玉宝新增于2016-11-09 9:42:52</para>
    /// </summary>
    public abstract class CacheProvider : IDisposable
    {
        /// <summary>
        /// 缓存组件
        /// </summary>
        public ICacheContext CacheContext { get; private set; }

        /// <summary>
        /// 动态设置缓存对象的新实例
        /// </summary>
        /// <param name="cacheContext">缓存实例对象</param>
        public void SetCacheInstance(ICacheContext cacheContext)
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

            if (!typeof(ICacheContext).IsAssignableFrom(cacheContextType))
            {
                throw new ArgumentException(
                    string.Format(CultureInfo.CurrentCulture, "该类型 {0} 必须继承自抽象类CacheContext", cacheContextType),
                    "cacheContextType");
            }

            try
            {
                CacheContext = Activator.CreateInstance(cacheContextType) as ICacheContext;
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
