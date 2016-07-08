// ***********************************************************************
// Assembly         : Infrastructure
// Author           : Administrator
// Created          : 09-22-2015
//
// ***********************************************************************
// <copyright file="CookieHelper.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>Cookie辅助</summary>
// ***********************************************************************

using System;
using System.Web;

namespace Infrastructure
{
    /// <summary>
    /// Cookie帮助类
    /// </summary>
    public class CookieHelper
    {
        /// <summary>
        /// 写cookie值
        /// </summary>
        /// <param name="strName">名称</param>
        /// <param name="strValue">值</param>
        public static void WriteCookie(string strName, string strValue)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[strName];
            if (cookie == null)
            {
                cookie = new HttpCookie(strName);
            }
            cookie.Value = strValue;
            HttpContext.Current.Response.AppendCookie(cookie);

        }
        /// <summary>
        /// 写cookie值
        /// </summary>
        /// <param name="strName">名称</param>
        /// <param name="strValue">值</param>
        /// <param name="strValue">过期时间(分钟)</param>
        public static void WriteCookie(string strName, string strValue, int expires)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[strName];
            if (cookie == null)
            {
                cookie = new HttpCookie(strName);
            }
            cookie.Value = strValue;
            cookie.Expires = DateTime.Now.AddMinutes(expires);
            HttpContext.Current.Response.AppendCookie(cookie);

        }

        /// <summary>
        /// 读cookie值
        /// </summary>
        /// <param name="strName">名称</param>
        /// <returns>cookie值</returns>
        public static string GetCookie(string strName)
        {
            if (HttpContext.Current.Request.Cookies[strName] != null)
            {
                return HttpContext.Current.Request.Cookies[strName].Value.ToString();
            }
            return "";
        }

        /// <summary>
        /// Get cookie expiry date that was set in the cookie value 
        /// </summary>
        /// <param name="cookie"></param>
        /// <returns></returns>
        public static DateTime GetExpirationDate(HttpCookie cookie)
        {
            if (String.IsNullOrEmpty(cookie.Value))
            {
                return DateTime.MinValue;
            }
            string strDateTime = cookie.Value.Substring(cookie.Value.IndexOf("|") + 1);
            return Convert.ToDateTime(strDateTime);
        }

        /// <summary>
        /// Set cookie value using the token and the expiry date
        /// </summary>
        /// <param name="value"></param>
        /// <param name="minutes"></param>
        /// <returns></returns>
        public static string BuildCookueValue(string value, int minutes)
        {
            return String.Format("{0}|{1}", value, DateTime.Now.AddMinutes(minutes).ToString());
        }

        /// <summary>
        /// Reads cookie value from the cookie
        /// </summary>
        /// <param name="cookie"></param>
        /// <returns></returns>
        public static string GetCookieValue(HttpCookie cookie)
        {
            if (String.IsNullOrEmpty(cookie.Value))
            {
                return cookie.Value;
            }
            return cookie.Value.Substring(0, cookie.Value.IndexOf("|"));
        }
    }
}
