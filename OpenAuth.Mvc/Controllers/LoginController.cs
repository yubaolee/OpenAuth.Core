using System;
using System.Configuration;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App.SSO;

namespace OpenAuth.Mvc.Controllers
{
    public class LoginController : Controller
    {
        private string _appKey = ConfigurationManager.AppSettings["SSOAppKey"];

        // GET: Login
        public ActionResult Index()
        {
            ViewBag.AppKey = _appKey;
            return View();
        }

        [HttpPost]
        public string Index(string username, string password)
        {
            var resp = new Response();
            try
            {
                var result = AuthUtil.Login(_appKey, username, password);
                resp.Status = result.Success;
                if (result.Success)
                {
                    resp.Result = "/home/index?Token=" + result.Token;
                }
                else
                {
                    resp.Message = "登陆失败";
                }
            }
            catch (Exception e)
            {
                resp.Status = false;
                resp.Message = e.Message;
            }
            return JsonHelper.Instance.Serialize(resp);
        }

        /// <summary>
        /// 开发者登陆
        /// </summary>
        public ActionResult LoginByDev()
        {
            try
            {
                var result = AuthUtil.Login(_appKey, "System","123456");
                if (result.Success)
                    return Redirect("/home/index?Token=" + result.Token);
                else
                {
                    return RedirectToAction("Index", "Login");

                }

            }
            catch (Exception e)
            {
                return RedirectToAction("Index", "Login");
            }
        }

        public ActionResult Logout()
        {

            AuthUtil.Logout();
            return RedirectToAction("Index", "Login");
        }
    }
}