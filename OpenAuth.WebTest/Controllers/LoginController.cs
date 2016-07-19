using System.Configuration;
using System.Web.Mvc;
using OpenAuth.App.SSO;

namespace OpenAuth.WebTest.Controllers
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
            var result = AuthUtil.Login(_appKey, username, password);
            if (result.Success)
                return Redirect("/home/index?Token=" + result.Token);
            else
            {
                return View(result);
            }
        }

        public ActionResult Logout()
        {
            AuthUtil.Logout();
            return Redirect("/Home/Index");
        }
    }
}