using System;
using Enyim.Caching;
using Enyim.Caching.Memcached;
using Microsoft.Extensions.Options;
using StackExchange.Redis;

namespace Infrastructure.Cache
{
    /// <summary>
    /// 缓存redis实现
    /// </summary>
    public sealed class RedisCacheContext : ICacheContext
    {
        private ConnectionMultiplexer _conn { get; set; }
        private IDatabase iDatabase { get; set; }

        public RedisCacheContext(IOptions<AppSetting> options)
        {
            _conn = ConnectionMultiplexer.Connect(options.Value.RedisConf);
            iDatabase = _conn.GetDatabase();
        }

        public override T Get<T>(string key)
        {
            RedisValue value = iDatabase.StringGet(key);
            if (!value.HasValue)
            {
                return default(T);
            }
            
            if (typeof(T) == typeof(string))
            {
                return (T) Convert.ChangeType(value, typeof(T));
            }
            else
            {
                return JsonHelper.Instance.Deserialize<T>(value);
            }
        }

        public override bool Set<T>(string key, T t, DateTime expire)
        {
            if (typeof(T) == typeof(string))
            {
                return iDatabase.StringSet(key, t.ToString(), expire-DateTime.Now);
            }
            else
            {
                return iDatabase.StringSet(key, JsonHelper.Instance.Serialize(t), expire - DateTime.Now);
            }
        }

        public override bool Remove(string key)
        {
            return iDatabase.KeyDelete(key);
        }
    }
}