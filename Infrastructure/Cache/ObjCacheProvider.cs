// ***********************************************************************
// Assembly         : Helper
// Author           : Administrator
// Created          : 12-21-2016
//
// Last Modified By : Administrator
// Last Modified On : 12-22-2016
// Contact : 
// File: ObjCacheProvider.cs
// ***********************************************************************


using System;

namespace Infrastructure.Cache
{
    /// <summary>
    ///  缓存工厂实现
    /// 这样做是方便换其他的缓存时（如memcachedContext）只换这一个地方即可
    /// </summary>
    public class ObjCacheProvider<T> : CacheProvider
    {
        public ObjCacheProvider()
        {
            SetCacheInstance(new CacheContext());
        }

        public bool Create(string key, T val, DateTime expire)
        {
            //设置缓存
            return CacheContext.Set<T>(key, val, expire);
        }

        /// <summary>
        /// 根据失效时间获取缓存
        /// <para>李玉宝于2016-11-08 16:54:04</para>
        /// </summary>
        /// <param name="key">The key.</param>
        public T GetCache(string key)
        {
            return CacheContext.Get<T>(key);
        }

        public void Remove(string key)
        {
            CacheContext.Remove(key);
        }
    }
}