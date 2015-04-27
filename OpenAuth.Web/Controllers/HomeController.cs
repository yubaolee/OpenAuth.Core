using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using OpenAuth.App;
using OpenAuth.App.DTO;
using OpenAuth.Infrastructure.Repository;

namespace OpenAuth.Web.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string username, string password)
        {
            var request = new LoginRequest {UserName = username, Password = password};
            var loginApp = new LoginApp(new UserRepository());
            var response = loginApp.Login(request);
            return Json(new{Success= response.Success,Message=response.Message});
        }

    }
}
