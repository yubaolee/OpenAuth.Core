// ***********************************************************************
// Assembly         : Infrastructure
// Author           : Administrator
// Created          : 09-22-2015
//
// Last Modified By : Administrator
// Last Modified On : 09-22-2015
// ***********************************************************************
// <copyright file="SessionHelper.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>SESSION辅助类</summary>
// ***********************************************************************

using System;
using System.Web;

namespace Infrastructure.Helper
{
    /// <summary>
    /// Session 帮助类
    /// </summary>
    public class SessionHelper
    {
        private static readonly string SessionUser = "SESSION_USER";
        public static void AddSessionUser<T>(T user)
        {
            HttpContext rq = HttpContext.Current;
            rq.Session[SessionUser] = user;
        }
        public static T GetSessionUser<T>()
        {
            try 
            { 
                HttpContext rq = HttpContext.Current;
                return (T)rq.Session[SessionUser];
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        public static void Clear()
        {
            HttpContext rq = HttpContext.Current;
            rq.Session[SessionUser] = null;
        }
    }
}
