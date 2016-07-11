using System.Configuration;
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

        /// <summary>
        /// 跳转到后台管理页面
        /// </summary>
        public ActionResult Admin()
        {
            return Redirect(ConfigurationManager.AppSettings["OpenAuthURL"] + "?token=" + Request.Cookies["Token"].Value);
        }
       
    }
}