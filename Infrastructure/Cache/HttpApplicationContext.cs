// ***********************************************************************
// Assembly         : Helper
// Author           : Administrator
// Created          : 09-21-2016
//
// Last Modified By : Administrator
// Last Modified On : 11-09-2016
// Contact : 
// File: HttpApplicationContext.cs
// ***********************************************************************


using System;
using System.Web;

namespace Helper.Cache
{
    /// <summary>
    /// 基于HttpApplication的存储
    /// <para>李玉宝新增于2016-11-09 9:30:51</para>
    /// </summary>
    public sealed class HttpApplicationContext : ICacheContext
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