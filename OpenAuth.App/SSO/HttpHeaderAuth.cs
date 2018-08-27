using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using OpenAuth.App.Interface;
using System;

namespace OpenAuth.App.SSO
{
    /// <summary>
    /// 当使用纯前端的vue时，WebApi通过读取http header中的x-token获取到token信息
    /// </summary>
    public class HttpHeaderAuth : IAuth
    {
        private IHttpContextAccessor _httpContextAccessor;

        private AuthContextFactory _app;
        private LoginParse _loginParse;
        private ICacheContext _cacheContext;

        public HttpHeaderAuth(IHttpContextAccessor httpContextAccessor
            , AuthContextFactory app
            , LoginParse loginParse
            , ICacheContext cacheContext)
        {
            _httpContextAccessor = httpContextAccessor;
            _app = app;
            _loginParse = loginParse;
            _cacheContext = cacheContext;
        }

        private string GetToken()
        {
            string token = _httpContextAccessor.HttpContext.Request.Headers["X-Token"];
            return token;
        }

        public bool CheckLogin(string token = "", string otherInfo = "")
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
        /// <param name="otherInfo">The otherInfo.</param>
        /// <returns>LoginUserVM.</returns>
        public AuthStrategyContext GetCurrentUser(string otherInfo = "")
        {
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
        /// <param name="otherInfo">The otherInfo.</param>
        /// <returns>System.String.</returns>
        public string GetUserName(string otherInfo = "")
        {
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