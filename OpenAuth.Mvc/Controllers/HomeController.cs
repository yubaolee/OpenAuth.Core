using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using OpenAuth.App;

namespace OpenAuth.Mvc.Controllers
{
    public class HomeController : BaseController
    {
        private LoginApp _loginApp;

        public HomeController()
        {
            _loginApp = (LoginApp)DependencyResolver.Current.GetService(typeof(LoginApp));
        }
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Main()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        public string LoadUsers()
        {
            return JsonConvert.SerializeObject(_loginApp.LoadUsers());
        }

    }
}