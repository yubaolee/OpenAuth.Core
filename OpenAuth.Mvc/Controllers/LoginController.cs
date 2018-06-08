using System;
using Infrastructure;
using OpenAuth.App.SSO;
using Microsoft.AspNetCore.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class LoginController : Controller
    {
        private string _appKey = "openauth";

        private AuthUtil _authUtil;

        public LoginController(AuthUtil authUtil)
        {
            _authUtil = authUtil;
        }

        // GET: Login
        public ActionResult Index()
        {
            return View();
        }


        public string Login(string username, string password)
        {
            var resp = new Response();
            try
            {
                var result = _authUtil.Login(_appKey, username, password);
                if (result.Code == 200)
                {
                   Response.Cookies.Append("Token", result.Token);
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

        public ActionResult Logout()
        {

            _authUtil.Logout();
            return RedirectToAction("Index", "Login");
        }
    }
}