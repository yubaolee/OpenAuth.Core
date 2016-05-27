using System.Web.Mvc;
using Infrastructure;
using Infrastructure.Helper;
using OpenAuth.App;
using OpenAuth.App.ViewModel;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class HomeController : BaseController
    {
         private ModuleManagerApp _app;

         public HomeController()
         {
             _app = AutofacExt.GetFromFac<ModuleManagerApp>();
        }
        
        public ActionResult Index()
        {
            var user = AutofacExt.GetFromFac<LoginApp>().GetLoginUser();
            return View(user.Modules);
        }
        
        public ActionResult Main()
        {
            return View();
        }
        
        public ActionResult Git()
        {
            return View();
        }

        /// <summary>
        /// 所有页面按钮控制分部视图
        /// </summary>
        /// <returns>ActionResult.</returns>
        [ChildActionOnly]
        public ActionResult MenuHeader()
        {
            return View();
        }
    }
}