using System.Web.Mvc;
using Infrastructure;
using Infrastructure.Helper;
using OpenAuth.App;
using OpenAuth.App.ViewModel;

namespace OpenAuth.Mvc.Controllers
{
    public class HomeController : BaseController
    {
         private ModuleManagerApp _app;

         public HomeController()
        {
            _app = (ModuleManagerApp)DependencyResolver.Current.GetService(typeof(ModuleManagerApp));
        }

        public string GetModules(int parentId = 0)
        {
            return JsonHelper.Instance.Serialize(_app.LoadByParent(parentId));
        }
        public ActionResult Index()
        {
            var user = SessionHelper.GetSessionUser<LoginUserVM>();
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
    }
}