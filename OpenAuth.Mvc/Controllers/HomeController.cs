using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;

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
            return View(_app.LoadByParent(0));
        }

        public ActionResult Main()
        {
            return View();
        }
    }
}