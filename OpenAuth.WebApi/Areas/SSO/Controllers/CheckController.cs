// ***********************************************************************
// Assembly         : OpenAuth.WebApi
// Author           : yubaolee
// Created          : 07-11-2016
//
// Last Modified By : yubaolee
// Last Modified On : 07-11-2016
// Contact : 
// File: CheckController.cs
// ***********************************************************************

using System;
using System.Web.Http;
using Infrastructure;
using Infrastructure.Cache;
using OpenAuth.App;
using OpenAuth.App.SSO;
using System.Web.Mvc;
using OpenAuth.App.ViewModel;

namespace OpenAuth.WebApi.Areas.SSO.Controllers
{
    /// <summary>
    ///  sso验证
    /// <para>其他站点通过后台Post来认证</para>
    /// <para>或使用静态类OpenAuth.App.SSO.AuthUtil访问</para>
    /// </summary>
    public class CheckController : ApiController
    {
        private AuthorizeApp _app;
        private ObjCacheProvider<UserAuthSession> _objCacheProvider = new ObjCacheProvider<UserAuthSession>();
        public CheckController()
        {
            _app = AutofacExt.GetFromFac<AuthorizeApp>();
        }

        [System.Web.Mvc.HttpGet]
        public bool GetStatus(string token = "", string requestid = "")
        {
            if (_objCacheProvider.GetCache(token) != null)
            {
                return true;
            }

            return false;
        }

        [System.Web.Mvc.HttpGet]
        public UserWithAccessedCtrls GetUser(string token = "", string requestid = "")
        {
            string userName = GetUserName(token, requestid);
            if (!string.IsNullOrEmpty(userName))
            {
                return _app.GetAccessedControls(userName);
            }

            return null;
        }

        [System.Web.Mvc.HttpGet]
        public string GetUserName(string token, string requestid = "")
        {
            var user = _objCacheProvider.GetCache(token);
            if (user != null)
            {
                return user.UserName;
            }

            return string.Empty;
        }

        [System.Web.Mvc.HttpPost]
        public LoginResult Login(PassportLoginRequest request)
        {
            return SSOAuthUtil.Parse(request);
        }

        [System.Web.Mvc.HttpPost]
        public bool Logout(string token, string requestid)
        {
            try
            {
                _objCacheProvider.Remove(token);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}