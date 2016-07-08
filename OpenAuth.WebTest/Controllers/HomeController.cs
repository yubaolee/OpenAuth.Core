using System.Web.Mvc;
using OpenAuth.App;
using OpenAuth.App.SSO;

namespace OpenAuth.WebTest.Controllers
{
    public class HomeController :Controller
    {

        [SSOAuth]
        public ActionResult Index()
        {
            var currentUser = AuthUtil.GetCurrentUser();
            ViewBag.CurrentUser = currentUser;
            return View();
        }

        public ActionResult Admin()
        {
            return Redirect("http://localhost:56813?token=" + Request.Cookies["Token"].Value);
        }
       
    }
}