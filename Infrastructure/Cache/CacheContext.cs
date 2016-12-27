// ***********************************************************************
// Assembly         : Helper
// Author           : yubaolee
// Created          : 12-16-2016
//
// Last Modified By : yubaolee
// Last Modified On : 12-21-2016
// 使用微软默认带超时的Cache
// File: CacheContext.cs
// ***********************************************************************

using System;
using System.Web;

namespace Infrastructure.Cache
{
    public class CacheContext : ICacheContext
    {
        private readonly System.Web.Caching.Cache _objCache = HttpRuntime.Cache;
        public override T Get<T>(string key)
        {
            System.Web.Caching.Cache objCache = HttpRuntime.Cache;
            return (T) objCache[key];
        }

        public override bool Set<T>(string key, T t, DateTime expire)
        {
            var obj = Get<T>(key);
            if (obj != null)
            {
                Remove(key);
            }
                
            _objCache.Insert(key, t, null, expire, System.Web.Caching.Cache.NoSlidingExpiration);
            return true;
        }

        public override bool Remove(string key)
        {
            _objCache.Remove(key);
            return true;
        }
    }
}
