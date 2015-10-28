using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;

namespace OpenAuth.Mvc.Controllers
{
	public class OrgManagerController : BaseController
	{
		private OrgManagerApp _orgApp;

		public OrgManagerController()
		{
			_orgApp = (OrgManagerApp) DependencyResolver.Current.GetService(typeof (OrgManagerApp));
		}
		//
		// GET: /OrgManager/
		public ActionResult Index()
		{
			return View();
		}


		public string LoadOrg()
		{
			var orgs = _orgApp.GetAll();
			return JsonHelper.Instance.Serialize(orgs);
		}

	    public JsonResult LoadTree()
	    {
	        return Json(_orgApp.GetAll().Select(o =>new
	        {
               id = o.Id,
               pId = o.ParentId,
               name = o.Name,
               text = o.Name
	        }), JsonRequestBehavior.AllowGet);
	    }
	}
}