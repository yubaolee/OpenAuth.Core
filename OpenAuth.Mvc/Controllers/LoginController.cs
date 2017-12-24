using System;
using System.Configuration;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App.SSO;
using System.Web;

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
            var resp = new LoginResult();
            try
            {
                var result = AuthUtil.Login(_appKey, username, password);
                if (result.Code == 200)
                {

                    var cookie = new HttpCookie("Token", result.Token)
                    {
                        Expires = DateTime.Now.AddDays(10)
                    };
                    Response.Cookies.Add(cookie);
                    resp.Result = "/home/index";
                    ///拿掉地址栏Token，因为特别不安全。
                    ///小王，xxx系统的地址是多少。。。然后账号就
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

        /// <summary>
        /// 开发者登录
        /// </summary>
        public ActionResult LoginByDev()
        {
            try
            {
                var result = AuthUtil.Login(_appKey, "System", "123456");
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