// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : yubaolee
// Created          : 07-08-2016
//
// Last Modified By : yubaolee
// Last Modified On : 07-08-2016
// Contact : Microsoft
// File: AuthUtil.cs
// ***********************************************************************


using System;
using System.Configuration;
using System.Web;
using Infrastructure;
using OpenAuth.App.ViewModel;

namespace OpenAuth.App.SSO
{
    public class AuthUtil
    {
        static HttpHelper _helper = new HttpHelper(ConfigurationManager.AppSettings["SSOPassport"]);

        private static string GetToken()
        {
            string token = HttpContext.Current.Request.QueryString["Token"];
            if (!string.IsNullOrEmpty(token)) return token;

            var cookie = HttpContext.Current.Request.Cookies["Token"];
            return cookie == null ? string.Empty : cookie.Value;
        }

        public static bool CheckLogin(string token, string remark = "")
        {
            if (string.IsNullOrEmpty(token) || string.IsNullOrEmpty(GetToken()))
                return false;

            var requestUri = string.Format("/SSO/Check/GetStatus?token={0}&requestid={1}", token, remark);

            try
            {
                var value = _helper.Get(null, requestUri);
                return bool.Parse(value);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static bool CheckLogin(string remark="")
        {
            return CheckLogin(GetToken(), remark);
        }

        public static LoginUserVM GetCurrentUser(string remark = "")
        {

            var requestUri = string.Format("/SSO/Check/GetUser?token={0}&requestid={1}", GetToken(), remark);

            try
            {
                var value = _helper.Get<LoginUserVM>(null, requestUri);
                return value;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 登陆接口
        /// </summary>
        /// <param name="appKey">应用程序key.</param>
        /// <param name="username">用户名</param>
        /// <param name="pwd">密码</param>
        /// <returns>System.String.</returns>
        public static string Login(string appKey, string username, string pwd)
        {
            var requestUri = "/SSO/Login/Check";

            try
            {
                var value = _helper.Post(new
                {
                    AppKey = appKey,
                    UserName = username,
                    Password = pwd
                }, requestUri);

                var result = JsonHelper.Instance.Deserialize<LoginResult>(value);
                if (result.Success)
                {
                    return result.Token;
                }
                else
                {
                    return string.Empty;
                }
            }
            catch (Exception ex)
            {
                return string.Empty;
            }
        }

        /// <summary>
        /// 注销
        /// </summary>
        public static bool Logout()
        {
            var token = GetToken();
            if (string.IsNullOrEmpty(token)) return true;

            var requestUri = string.Format("/SSO/Login/Logout?token={0}&requestid={1}", token, "");

            try
            {
                var value = _helper.Post(requestUri);

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}