using System;
using Infrastructure.Cache;

namespace OpenAuth.WebApi.Areas.SSO.Models.Services
{
    public class UserAuthSessionService : ServiceContext
    {
        public UserAuthSessionService()
        {
            SetCacheInstance(new SessionContext());
        }

        public bool Create(UserAuthSession model)
        {
            //设置缓存
            return CacheContext.Set(model.Token, model);
        }

        public UserAuthSession Get(string token)
        {
            var sessionCacheItem = CacheContext.Get<UserAuthSession>(token);
            return sessionCacheItem;
        }

        public bool GetCache(string token)
        {
            var cache = Get(token);
            if (cache == null) return false;

            if (cache.InvalidTime > DateTime.Now)
            {
                //延长
                cache.InvalidTime = DateTime.Now.AddMinutes(5);
                //设置缓存
                CacheContext.Set(cache.Token, cache);

                return true;
            }

            //移除无效Session缓存
            Remove(token);

            return false;
        }

        public void Remove(string token)
        {
            CacheContext.Remove(token);
        }
    }
}