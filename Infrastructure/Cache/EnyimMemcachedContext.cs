// ***********************************************************************
// Assembly         : Infrastructure
// Author           : yubaolee
// Created          : 06-21-2016
//
// Last Modified By : yubaolee
// Last Modified On : 06-21-2016
// Contact : 
// File: EnyimMemcachedContext.cs
// ***********************************************************************


using System;
using Enyim.Caching;
using Enyim.Caching.Memcached;

namespace Infrastructure.Cache
{
    public sealed class EnyimMemcachedContext : ICacheContext
    {
        private static readonly MemcachedClient _memcachedClient  = new MemcachedClient();

        public override T Get<T>(string key)
        {
            return _memcachedClient.Get<T>(key);
        }

        public override bool Set<T>(string key, T t, DateTime expire)
        {
            return _memcachedClient.Store(StoreMode.Set, key, t, expire);
        }

        public override bool Remove(string key)
        {
            return _memcachedClient.Remove(key);
        }
    }
}