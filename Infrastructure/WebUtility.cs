using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Infrastructure
{
    public static class WebUtility
    {
        /// <summary>
        /// 获取IP地址
        /// </summary>
        /// <returns>返回获取的ip地址</returns>
        public static string GetIP()
        {
            return GetIP(HttpContext.Current);
        }
        /// <summary>
        /// 透过代理获取真实IP
        /// </summary>
        /// <param name="httpContext">HttpContext</param>
        /// <returns>返回获取的ip地址</returns>
        public static string GetIP(HttpContext httpContext)
        {
            string userHostAddress = string.Empty;
            if (httpContext != null)
            {
                userHostAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (string.IsNullOrEmpty(userHostAddress))
                {
                    userHostAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                }
                if (string.IsNullOrEmpty(userHostAddress))
                {
                    userHostAddress = HttpContext.Current.Request.UserHostAddress;
                }
            }
            return userHostAddress;
        }
    }
}
