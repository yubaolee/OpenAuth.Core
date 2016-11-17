// ***********************************************************************
// Assembly         : OpenAuth.WebApi
// Author           : yubaolee
// Created          : 07-11-2016
//
// Last Modified By : yubaolee
// Last Modified On : 07-11-2016
// Contact : 
// File: CacheObjService.cs
// ***********************************************************************

using System;

namespace Helper.Cache
{
    /// <summary>
    /// 带超时结构的缓存
    /// </summary>
    public class ObjCacheProvider<T> : CacheProvider
    {
        public ObjCacheProvider()
        {
            SetCacheInstance(new HttpApplicationContext());
        }

        public bool Create(string key, T val)
        {
            var cacheobj = new CacheObj<T>
            {
                key = key,
                InvalidTime = DateTime.Now.AddMinutes(5),
                CreateTime = DateTime.Now,
                Obj = val
            };
            //设置缓存
            return CacheContext.Set(key, cacheobj);
        }

        /// <summary>
        /// 根据失效时间获取缓存
        /// <para>李玉宝于2016-11-08 16:54:04</para>
        /// </summary>
        /// <param name="key">The key.</param>
        public T GetCache(string key)
        {
            var cache = CacheContext.Get<CacheObj<T>>(key);
            if (cache == null) return default(T);

            if (cache.InvalidTime > DateTime.Now)
            {
                return cache.Obj;
            }

            //移除无效Session缓存
            Remove(key);

            return default(T);
        }

        public void Remove(string key)
        {
            CacheContext.Remove(key);
        }
    }
}