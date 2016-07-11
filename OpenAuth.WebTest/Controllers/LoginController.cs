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
            var result = AuthUtil.Login("670b14728ad9902aecba32e22fa4f6bd", username, password);
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