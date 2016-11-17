using System;

namespace Helper.Cache
{
    /// <summary>
    /// 缓存接口
    /// </summary>
    public abstract class ICacheContext : IDisposable
    {
        /// <summary>
        /// 初始化缓存组件
        /// </summary>
        public abstract void Init();

        /// <summary>
        /// 获取缓存项
        /// </summary>
        /// <typeparam name="T">缓存对象类型</typeparam>
        /// <param name="key">键</param>
        /// <returns>缓存对象</returns>
        public abstract T Get<T>(string key) where T : class;

        /// <summary>
        /// 设置缓存项
        /// </summary>
        /// <typeparam name="T">缓存对象类型</typeparam>
        /// <param name="key">键</param>
        /// <param name="t">缓存对象</param>
        /// <returns>true成功,false失败</returns>
        public abstract bool Set<T>(string key, T t) where T : class;

        /// <summary>
        /// 移除一个缓存项
        /// </summary>
        /// <param name="key">缓存项key</param>
        /// <returns>true成功,false失败</returns>
        public abstract bool Remove(string key);

        /// <summary>
        /// 释放缓存组件
        /// </summary>
        public abstract void Dispose();
    }
}