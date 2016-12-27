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
using System.Web.Mvc;
using Infrastructure;
using Infrastructure.Cache;
using OpenAuth.App;
using OpenAuth.App.SSO;

namespace OpenAuth.WebApi.Areas.SSO.Controllers
{
    /// <summary>
    ///  sso验证
    /// <para>其他站点通过后台Post来认证</para>
    /// <para>或使用静态类OpenAuth.App.SSO.AuthUtil访问</para>
    /// </summary>
    public class CheckController : Controller
    {
        private AuthorizeApp _app;
        private ObjCacheProvider<UserAuthSession> _objCacheProvider = new ObjCacheProvider<UserAuthSession>();
        public CheckController()
        {
            _app = AutofacExt.GetFromFac<AuthorizeApp>();
        }

        public bool GetStatus(string token = "", string requestid = "")
        {
            if (_objCacheProvider.GetCache(token) != null)
            {
                return true;
            }

            return false;
        }

        public string GetUser(string token = "", string requestid = "")
        {
            string userName = GetUserName(token, requestid);
            if (!string.IsNullOrEmpty(userName))
            {
                return JsonHelper.Instance.Serialize(_app.GetAccessedControls(userName));
            }

            return string.Empty;
        }

        public string GetUserName(string token, string requestid = "")
        {
            var user = _objCacheProvider.GetCache(token);
            if (user != null)
            {
                return user.UserName;
            }

            return string.Empty;
        }

        [HttpPost]
        public string Login(PassportLoginRequest request)
        {
            return JsonHelper.Instance.Serialize(SSOAuthUtil.Parse(request));
        }

        [HttpPost]
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