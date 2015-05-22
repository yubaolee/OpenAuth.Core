using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OpenAuth.App;
using OpenAuth.App.DTO;
using OpenAuth.Domain.Service;
using OpenAuth.Infrastructure.Repository;

namespace OpenAuth.Web.Controllers
{
    public class MenuController : Controller
    {
        //
        // GET: /Menu/

        public ActionResult LeftMenu()
        {
            var service = new MenuService(new UserRepository());
            MenuApp app = new MenuApp(service);
            var request = new MenuForUserRequest {UserId = LoginCacheApp.GetLogin().UserId};
            var response = app.LoadFor(request);
            return PartialView(response);
        }

    }
}
