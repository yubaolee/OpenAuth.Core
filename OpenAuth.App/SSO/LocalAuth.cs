
using System;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using OpenAuth.App.Interface;
using OpenAuth.App.Response;

namespace OpenAuth.App.SSO
{
    /// <summary>
    /// 使用本地登录。这个注入IAuth时，只需要OpenAuth.Mvc一个项目即可，无需webapi的支持
    /// </summary>
    public class LocalAuth :IAuth
    {
        private IOptions<AppSetting> _appConfiguration;
        private IHttpContextAccessor _httpContextAccessor;

        private AuthorizeApp _app;
        private LoginParse _loginParse;
        private ObjCacheProvider<UserAuthSession> _objCacheProvider;

        public LocalAuth(IOptions<AppSetting> appConfiguration
            , IHttpContextAccessor httpContextAccessor
            , AuthorizeApp app
            , LoginParse loginParse
            , ObjCacheProvider<UserAuthSession> objCacheProvider)
        {
            _appConfiguration = appConfiguration;
            _httpContextAccessor = httpContextAccessor;
            _app = app;
            _loginParse = loginParse;
            _objCacheProvider = objCacheProvider;
        }

        private string GetToken()
        {
            string token = _httpContextAccessor.HttpContext.Request.Query["Token"];
            if (!String.IsNullOrEmpty(token)) return token;

            var cookie = _httpContextAccessor.HttpContext.Request.Cookies["Token"];
            return cookie == null ? String.Empty : cookie;
        }

        public bool CheckLogin(string token="", string otherInfo = "")
        {
            if (string.IsNullOrEmpty(token))
            {
                token = GetToken();
            }

            if (string.IsNullOrEmpty(token))
            {
                return false;
            }
         
            try
            {
                var result = _objCacheProvider.GetCache(token) != null;
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 获取当前登录的用户信息
        /// <para>通过URL中的Token参数或Cookie中的Token</para>
        /// </summary>
        /// <param name="otherInfo">The otherInfo.</param>
        /// <returns>LoginUserVM.</returns>
        public UserWithAccessedCtrls GetCurrentUser(string otherInfo = "")
        {
            try
            {
                var userctrls = new UserWithAccessedCtrls();
                var user = _objCacheProvider.GetCache(GetToken());
                if (user != null)
                {
                   userctrls = _app.GetAccessedControls(user.Account);
                }

                return userctrls;
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
        /// <param name="otherInfo">The otherInfo.</param>
        /// <returns>System.String.</returns>
        public string GetUserName(string otherInfo = "")
        {
           try
            {
                var user = _objCacheProvider.GetCache(GetToken());
                if (user != null)
                {
                    return user.Account;
                }
                else
                {
                    return "";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 登录接口
        /// </summary>
        /// <param name="appKey">应用程序key.</param>
        /// <param name="username">用户名</param>
        /// <param name="pwd">密码</param>
        /// <returns>System.String.</returns>
        public LoginResult Login(string appKey, string username, string pwd)
        {
          try
            {
                return  _loginParse.Do(new PassportLoginRequest
                {
                    AppKey = appKey,
                    Account = username,
                    Password = pwd
                });
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        /// <summary>
        /// 注销
        /// </summary>
        public bool Logout()
        {
            var token = GetToken();
            if (String.IsNullOrEmpty(token)) return true;

            try
            {
                _objCacheProvider.Remove(token);

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}