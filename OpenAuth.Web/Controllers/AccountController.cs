using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OpenAuth.App;
using OpenAuth.App.DTO;
using OpenAuth.Domain.Service;
using OpenAuth.Infrastructure.Repository;

namespace OpenAuth.Web.Controllers
{
    public class AccountController : Controller
    {
        //
        // GET: /Account/

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string username, string password)
        {
            var request = new LoginRequest { UserName = username, Password = password };
            var loginApp = new LoginApp(new LoginService(new UserRepository()));
            var response = loginApp.Login(request);
            LoginCacheApp.SetLogin(response);
            return Json(new { response.Success, response.Message });
        }

    }
}
