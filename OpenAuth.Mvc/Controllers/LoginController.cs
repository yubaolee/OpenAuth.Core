using System;
using System.Configuration;
using System.Web.Mvc;
using OpenAuth.App.SSO;
using OpenAuth.Mvc.Models;

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
        public ActionResult Index(string username, string password)
        {
            try
            {
                var result = AuthUtil.Login(_appKey, username, password);
                if (result.Success)
                    return Redirect("/home/index?Token=" + result.Token);
                else
                {
                    var response = new BjuiResponse
                    {
                        statusCode = "300",
                        message = "登陆失败"
                    };
                    return View(response);
                }
                
            }
            catch (Exception e)
            {
                var response = new BjuiResponse
                {
                    statusCode = "300",
                    message = e.Message
                };
                return View(response);
            }
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