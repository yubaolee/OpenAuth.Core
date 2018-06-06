using System.Text;
using Microsoft.AspNetCore.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            return View();
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