using System.Configuration;
using System.Web.Mvc;
using OpenAuth.App.SSO;
using System.Web;
using System;

namespace OpenAuth.WebTest.Controllers
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
        public ActionResult Index(string username, string password)
        {
            var result = AuthUtil.Login(_appKey, username, password);
            if (result.Code == 200)
            {

                var cookie = new HttpCookie("Token", result.Token)
                {
                    Expires = DateTime.Now.AddDays(10)
                };
                Response.Cookies.Add(cookie);
                return Redirect("/home/index");
                ///拿掉地址栏Token，因为特别不安全。
                ///小王，xxx系统的地址是多少。。。然后账号就
            }
            else
            {
                return View(result);
            }
        }

        public ActionResult Logout()
        {
            AuthUtil.Logout();
            return Redirect("/Home/Index");
        }
    }
}