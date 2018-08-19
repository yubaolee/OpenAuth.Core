// ***********************************************************************
// Assembly         : OpenAuth.WebApi
// Author           : yubaolee
// Created          : 07-11-2016
//
// Last Modified By : yubaolee
// Last Modified On : 07-11-2016
// Contact :
// File: CheckController.cs
// 登录相关的操作
// ***********************************************************************

using System;
using System.Collections.Generic;
using Infrastructure;
using Infrastructure.Cache;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Response;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;

namespace OpenAuth.WebApi.Controllers
{
    /// <summary>
    ///  sso验证
    /// <para>其他站点通过后台Post来认证</para>
    /// <para>或使用静态类OpenAuth.App.SSO.IAuth访问</para>
    /// </summary>
    public class CheckController : ControllerBase
    {
        private AuthContextFactory _app;
        private LoginParse _loginParse;
        private ICacheContext _cacheContext;

        public CheckController(AuthContextFactory app, LoginParse loginParse, ICacheContext cacheContext)
        {
            _app = app;
            _loginParse = loginParse;
            _cacheContext = cacheContext;
        }

        /// <summary>
        /// 检验token是否有效
        /// </summary>
        /// <param name="token">The token.</param>
        /// <param name="requestid">备用参数.</param>
        [HttpGet]
        public Response<bool> GetStatus(string token, string requestid = "")
        {
            var result = new Response<bool>();
            try
            {
                result.Result = _cacheContext.Get<UserAuthSession>(token) != null;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }

            return result;
        }

        [HttpGet]
        public Response<List<Role>> GetRoles(string token, string requestid = "")
        {
            var result = new Response<List<Role>>();
            try
            {
                var user = _cacheContext.Get<UserAuthSession>(token);
                if (user != null)
                {
                    result.Result = GetAuthStrategyContext(token, requestid).Roles;
                }
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException != null
                    ? "OpenAuth.WebAPI数据库访问失败:" + ex.InnerException.Message
                    : "OpenAuth.WebAPI数据库访问失败:" + ex.Message;
            }

            return result;
        }

        [HttpGet]
        public Response<List<Org>> GetOrgs(string token, string requestid = "")
        {
            var result = new Response<List<Org>>();
            try
            {
                var user = _cacheContext.Get<UserAuthSession>(token);
                if (user != null)
                {
                    result.Result = GetAuthStrategyContext(token, requestid).Orgs;
                }
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException != null
                    ? "OpenAuth.WebAPI数据库访问失败:" + ex.InnerException.Message
                    : "OpenAuth.WebAPI数据库访问失败:" + ex.Message;
            }

            return result;
        }

        [HttpGet]
        public Response<List<ModuleView>> GetModules(string token, string requestid = "")
        {
            var result = new Response<List<ModuleView>>();
            try
            {
                var user = _cacheContext.Get<UserAuthSession>(token);
                if (user != null)
                {
                    result.Result = GetAuthStrategyContext(token, requestid).Modules;
                }
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException != null
                    ? "OpenAuth.WebAPI数据库访问失败:" + ex.InnerException.Message
                    : "OpenAuth.WebAPI数据库访问失败:" + ex.Message;
            }

            return result;
        }

        [HttpGet]
        public Response<List<Resource>> GgetResources(string token, string requestid = "")
        {
            var result = new Response<List<Resource>>();
            try
            {
                var user = _cacheContext.Get<UserAuthSession>(token);
                if (user != null)
                {
                    result.Result = GetAuthStrategyContext(token, requestid).Resources;
                }
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException != null
                    ? "OpenAuth.WebAPI数据库访问失败:" + ex.InnerException.Message
                    : "OpenAuth.WebAPI数据库访问失败:" + ex.Message;
            }

            return result;
        }

        private AuthStrategyContext GetAuthStrategyContext(string token, string requestid = "")
        {
            AuthStrategyContext context = null;

            var user = _cacheContext.Get<UserAuthSession>(token);
            if (user != null)
            {
                context = _app.GetAuthStrategyContext(user.Account);
            }

            return context;
        }

        /// <summary>
        /// 根据token获取用户名称
        /// </summary>
        /// <param name="token"></param>
        /// <param name="requestid">备用参数.</param>
        [HttpGet]
        public Response<string> GetUserName(string token, string requestid = "")
        {
            var result = new Response<string>();
            try
            {
                var user = _cacheContext.Get<UserAuthSession>(token);
                if (user != null)
                {
                    result.Result = user.Account;
                }
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }

            return result;
        }

        /// <summary>
        /// 登录接口
        /// </summary>
        /// <param name="request">登录参数</param>
        /// <returns></returns>
        [HttpPost]
        public LoginResult Login([FromBody]PassportLoginRequest request)
        {
            var result = new LoginResult();
            try
            {
                result = _loginParse.Do(request);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }

            return result;
        }

        /// <summary>
        /// 注销登录
        /// </summary>
        /// <param name="token"></param>
        /// <param name="requestid">备用参数.</param>
        [HttpPost]
        public Response<bool> Logout(string token, string requestid = "")
        {
            var resp = new Response<bool>();
            try
            {
                resp.Result = _cacheContext.Remove(token);
            }
            catch (Exception e)
            {
                resp.Result = false;
                resp.Message = e.Message;
            }

            return resp;
        }
    }
}