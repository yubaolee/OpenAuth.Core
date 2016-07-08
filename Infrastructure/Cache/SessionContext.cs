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
using System.Web;

namespace Infrastructure.Cache
{
    public sealed class SessionContext : CacheContext
    {

        public override void Init()
        {
        }

        public override T Get<T>(string key)
        {
            return (T) HttpContext.Current.Application[key];
        }

        public override bool Set<T>(string key, T t)
        {
            try
            {
                HttpContext.Current.Application[key] = t;
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public override bool Remove(string key)
        {
            try
            {
                HttpContext.Current.Application[key] = null;
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public override void Dispose()
        {
          
        }
    }
}