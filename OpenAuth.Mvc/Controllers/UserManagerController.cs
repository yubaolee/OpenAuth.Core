using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class UserManagerController : BaseController
    {
        //
        // GET: /UserManager/
        public ActionResult Index()
        {
            return View();
        }
	}
}