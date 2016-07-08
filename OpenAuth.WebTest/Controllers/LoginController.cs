using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OpenAuth.App.SSO;

namespace OpenAuth.WebTest.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(string username, string password)
        {
            var token = AuthUtil.Login("670b14728ad9902aecba32e22fa4f6bd", username, "123");
            if (!string.IsNullOrEmpty(token))
                return Redirect("/home/index?Token=" + token);
            else
            {
                return View();
            }
        }
    }
}