using System.Web.Mvc;
using OpenAuth.App;

namespace OpenAuth.Web.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            if(LoginCacheApp.GetLogin() == null)
                return RedirectToAction("Login", "Account");
            return View();
        }


    }
}
