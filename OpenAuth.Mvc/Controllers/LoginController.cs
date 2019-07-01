using System;
using Infrastructure;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using OpenAuth.App;
using OpenAuth.App.Interface;

namespace OpenAuth.Mvc.Controllers
{
    public class LoginController : Controller
    {
        private string _appKey = "openauth";
        private IOptions<AppSetting> _appConfiguration;

        private IAuth _authUtil;

        public LoginController(IAuth authUtil, IOptions<AppSetting> appConfiguration)
        {
            _authUtil = authUtil;
            _appConfiguration = appConfiguration;
        }

        // GET: Login
        [AllowAnonymous]
        public ActionResult Index()
        {
            return View();
        }

        [AllowAnonymous]
        public string Login(string username, string password)
        {
            var resp = new Response();
            try
            {
                var result = _authUtil.Login(_appKey, username, password);
                if (result.Code == 200)
                {
                   Response.Cookies.Append(Define.TOKEN_NAME, result.Token);
                }
                else
                {
                    resp.Code = 500;
                    resp.Message = result.Message;
                }

            }
            catch (Exception e)
            {
                resp.Code = 500;
                resp.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(resp);
        }

        [AllowAnonymous]
        public ActionResult Logout()
        {
            if (_appConfiguration.Value.IsIdentityAuth)
            {
                return SignOut("Cookies", "oidc");
            }
            _authUtil.Logout();
            return RedirectToAction("Index", "Login");
        }
    }
}