using System.Web.Mvc;
using OpenAuth.App.SSO;

namespace OpenAuth.WebTest.Controllers
{
    public class HomeController :Controller
    {
        [SSOAuth]
        public ActionResult Index()
        {
            return View();
        }
       
    }
}