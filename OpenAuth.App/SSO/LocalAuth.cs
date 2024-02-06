using Infrastructure.Cache;
using Microsoft.AspNetCore.Http;
using OpenAuth.App.Interface;
using System;
using Infrastructure;
using Microsoft.Extensions.Options;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.SSO
{
    /// <summary>
    /// 使用本地登录。这个注入IAuth时，只需要OpenAuth.Mvc一个项目即可，无需webapi的支持
    /// </summary>
    public class LocalAuth : IAuth
    {
        private IHttpContextAccessor _httpContextAccessor;
        private IOptions<AppSetting> _appConfiguration;
        private SysLogApp _logApp;

        private AuthContextFactory _app;
        private LoginParse _loginParse;
        private ICacheContext _cacheContext;

        public LocalAuth(IHttpContextAccessor httpContextAccessor
            , AuthContextFactory app
            , LoginParse loginParse
            , ICacheContext cacheContext, IOptions<AppSetting> appConfiguration, SysLogApp logApp)
        {
            _httpContextAccessor = httpContextAccessor;
            _app = app;
            _loginParse = loginParse;
            _cacheContext = cacheContext;
            _appConfiguration = appConfiguration;
            _logApp = logApp;
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
            if (_appConfiguration.Value.IsIdentityAuth)
            {
                return new LoginResult
                {
                    Code = 500,
                    Message = "接口启动了OAuth认证,暂时不能使用该方式登录"
                };
            }

            var result = _loginParse.Do(new PassportLoginRequest
            {
                AppKey = appKey,
                Account = username,
                Password = pwd
            });

            var log = new SysLog
            {
                Content = $"用户登录,结果：{result.Message}",
                Result = result.Code == 200 ? 0 : 1,
                CreateId = username,
                CreateName = username,
                TypeName = "登录日志"
            };
            _logApp.Add(log);

            return result;
        }

        /// <summary>
        /// 注销，如果是Identity登录，需要在controller处理注销逻辑
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
            catch
            {
                return false;
            }

            
        }
    }
}