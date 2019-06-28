using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using OpenAuth.App.Interface;
using System;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;

namespace OpenAuth.App.SSO
{
    /// <summary>
    /// 使用本地登录。这个注入IAuth时，只需要OpenAuth.Mvc一个项目即可，无需webapi的支持
    /// </summary>
    public class LocalAuth : IAuth
    {
        private IHttpContextAccessor _httpContextAccessor;
        private IOptions<AppSetting> _appConfiguration;

        private AuthContextFactory _app;
        private LoginParse _loginParse;
        private ICacheContext _cacheContext;

        public LocalAuth(IHttpContextAccessor httpContextAccessor
            , AuthContextFactory app
            , LoginParse loginParse
            , ICacheContext cacheContext, IOptions<AppSetting> appConfiguration)
        {
            _httpContextAccessor = httpContextAccessor;
            _app = app;
            _loginParse = loginParse;
            _cacheContext = cacheContext;
            _appConfiguration = appConfiguration;
        }

        /// <summary>
        /// 如果是Identity，则返回信息为用户账号
        /// </summary>
        /// <returns></returns>
        private string GetToken()
        {
            if (_appConfiguration.Value.IsIdentityAuth)
            {
                return _httpContextAccessor.HttpContext.User.Identity.Name;
            }
            string token = _httpContextAccessor.HttpContext.Request.Query[Define.TOKEN_NAME];
            if (!String.IsNullOrEmpty(token)) return token;

            token = _httpContextAccessor.HttpContext.Request.Headers[Define.TOKEN_NAME];
            if (!String.IsNullOrEmpty(token)) return token;

            var cookie = _httpContextAccessor.HttpContext.Request.Cookies[Define.TOKEN_NAME];
            return cookie ?? String.Empty;
        }

        public bool CheckLogin(string token = "", string otherInfo = "")
        {
            if (_appConfiguration.Value.IsIdentityAuth)
            {
                return (!string.IsNullOrEmpty(_httpContextAccessor.HttpContext.User.Identity.Name));
            }

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
                var result = _cacheContext.Get<UserAuthSession>(token) != null;
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
        /// <param name="account">The account.</param>
        /// <returns>LoginUserVM.</returns>
        public AuthStrategyContext GetCurrentUser()
        {
            if (_appConfiguration.Value.IsIdentityAuth)
            {
                return _app.GetAuthStrategyContext(GetToken());
            }
            AuthStrategyContext context = null;
            var user = _cacheContext.Get<UserAuthSession>(GetToken());
            if (user != null)
            {
                context = _app.GetAuthStrategyContext(user.Account);
            }
            return context;
        }

        /// <summary>
        /// 获取当前登录的用户名
        /// <para>通过URL中的Token参数或Cookie中的Token</para>
        /// </summary>
        /// <param name="otherInfo">The account.</param>
        /// <returns>System.String.</returns>
        public string GetUserName(string otherInfo = "")
        {
            if (_appConfiguration.Value.IsIdentityAuth)
            {
                return _httpContextAccessor.HttpContext.User.Identity.Name;
            }

            var user = _cacheContext.Get<UserAuthSession>(GetToken());
            if (user != null)
            {
                return user.Account;
            }

            return "";
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
            return _loginParse.Do(new PassportLoginRequest
            {
                AppKey = appKey,
                Account = username,
                Password = pwd
            });
        }

        /// <summary>
        /// 注销
        /// </summary>
        public bool Logout()
        {
            if (_appConfiguration.Value.IsIdentityAuth)
            {
                _httpContextAccessor.HttpContext.SignOutAsync();
                return true;
            }
            var token = GetToken();
            if (String.IsNullOrEmpty(token)) return true;

            try
            {
                _cacheContext.Remove(token);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}