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
    /// <summary>
    /// 第三方网站登录验证类
    /// <para>登录时：</para>
    /// <code>
    ///  var result = AuthUtil.Login(AppKey, username, password);
    ///  if (result.Success)
    ///       return Redirect("/home/index?Token=" + result.Token);
    /// </code>
    /// </summary>
    public class AuthUtil
    {
        static HttpHelper _helper = new HttpHelper(ConfigurationManager.AppSettings["SSOPassport"]);

        private static string GetToken()
        {
            string token = HttpContext.Current.Request.QueryString["Token"];
            if (!String.IsNullOrEmpty(token)) return token;

            var cookie = HttpContext.Current.Request.Cookies["Token"];
            return cookie == null ? String.Empty : cookie.Value;
        }

        public static bool CheckLogin(string token, string remark = "")
        {
            if (String.IsNullOrEmpty(token) || String.IsNullOrEmpty(GetToken()))
                return false;

            var requestUri = String.Format("/api/Check/GetStatus?token={0}&requestid={1}", token, remark);

            try
            {
                var value = _helper.Get(null, requestUri);
                return Boolean.Parse(value);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 检查用户登录状态
        /// <para>通过URL中的Token参数或Cookie中的Token</para>
        /// </summary>
        /// <param name="remark">备注信息</param>
        public static bool CheckLogin(string remark="")
        {
            return CheckLogin(GetToken(), remark);
        }

        /// <summary>
        /// 获取当前登录的用户信息
        /// <para>通过URL中的Token参数或Cookie中的Token</para>
        /// </summary>
        /// <param name="remark">The remark.</param>
        /// <returns>LoginUserVM.</returns>
        public static UserWithAccessedCtrls GetCurrentUser(string remark = "")
        {

            var requestUri = String.Format("/api/Check/GetUser?token={0}&requestid={1}", GetToken(), remark);

            try
            {
                var value = _helper.Get<UserWithAccessedCtrls>(null, requestUri);
                return value;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        /// <summary>
        /// 获取当前登录的用户名
        /// <para>通过URL中的Token参数或Cookie中的Token</para>
        /// </summary>
        /// <param name="remark">The remark.</param>
        /// <returns>System.String.</returns>
        public static string GetUserName(string remark = "")
        {
            var requestUri = String.Format("/api/Check/GetUserName?token={0}&requestid={1}", GetToken(), remark);

            try
            {
                var value = _helper.Get<string>(null, requestUri);
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
        public static LoginResult Login(string appKey, string username, string pwd)
        {
            var requestUri = "/api/Check/Login";

            try
            {
                var value = _helper.Post(new
                {
                    AppKey = appKey,
                    UserName = username,
                    Password = pwd
                }, requestUri);

                var result = JsonHelper.Instance.Deserialize<LoginResult>(value);
                return result;
               
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        /// <summary>
        /// 注销
        /// </summary>
        public static bool Logout()
        {
            var token = GetToken();
            if (String.IsNullOrEmpty(token)) return true;

            var requestUri = String.Format("/api/Check/Logout?token={0}&requestid={1}", token, "");

            try
            {
                var value = _helper.Post(null, requestUri);

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}