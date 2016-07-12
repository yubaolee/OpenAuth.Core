// ***********************************************************************
// Assembly         : OpenAuth.WebApi
// Author           : yubaolee
// Created          : 07-11-2016
//
// Last Modified By : yubaolee
// Last Modified On : 07-11-2016
// Contact : 
// File: UserAuthSessionService.cs
// ***********************************************************************

using System;
using Infrastructure.Cache;

namespace OpenAuth.App.SSO
{
    /// <summary>
    /// 用户登录状态存储服务
    /// <para>测试环境用的是基于http application的SessionContext</para>
    /// <para>正式环境可以使用基于memcached的EnyimMemcachedContext</para>
    /// </summary>
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