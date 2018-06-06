using System;
using System.Configuration;
using Infrastructure;
using OpenAuth.App.SSO;
using System.Web;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Protocols;

namespace OpenAuth.Mvc.Controllers
{
    public class LoginController : Controller
    {
        private string _appKey = "OpenAuth.Net";

        // GET: Login
        public ActionResult Index()
        {
            ViewBag.AppKey = _appKey;
            return View();
        }

        [HttpPost]
        public string Index(string username, string password)
        {
            var resp = new LoginResult();
            try
            {
                var result = AuthUtil.Login(_appKey, username, password);
                if (result.Code == 200)
                {

                    Response.Cookies.Append("Token", result.Token);
                    resp.Result = "/home/index";
                }
                else
                {
                    resp.Message = "登录失败";
                }
            }
            catch (Exception e)
            {
                resp.Code = 500;
                resp.Message = e.Message;
            }
            return JsonHelper.Instance.Serialize(resp);
        }

        public string Login(string username, string password)
        {
            var resp = new Response();
            try
            {
                var result = AuthUtil.Login(_appKey, username, password);
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

            AuthUtil.Logout();
            return RedirectToAction("Index", "Login");
        }
    }
}