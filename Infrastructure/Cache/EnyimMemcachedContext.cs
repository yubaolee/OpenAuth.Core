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


using Enyim.Caching;
using Enyim.Caching.Memcached;

namespace Helper.Cache
{
    public sealed class EnyimMemcachedContext : ICacheContext
    {
        private readonly MemcachedClient _memcachedClient = new MemcachedClient("memcached");

        public override void Init()
        {
        }

        public override T Get<T>(string key)
        {
            return _memcachedClient.Get<T>(key);
        }

        public override bool Set<T>(string key, T t)
        {
            return _memcachedClient.Store(StoreMode.Set, key, t);
        }

        public override bool Remove(string key)
        {
            return _memcachedClient.Remove(key);
        }

        public override void Dispose()
        {
            if (_memcachedClient != null)
            {
                _memcachedClient.Dispose();
            }
        }
    }
}