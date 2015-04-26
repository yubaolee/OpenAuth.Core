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
        public ContentResult Login(string username, string password)
        {
            var request = new LoginRequest {UserName = username, Password = password};
            var loginApp = new LoginApp(new UserRepository());
            var response = loginApp.Login(request);
            if(response.Success)
               Response.Redirect("Home/Index");
            return Content(response.Message);
        }

    }
}
