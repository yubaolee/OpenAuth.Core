using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;

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
		    return JsonHelper.Instance.Serialize(_orgApp.GetAll());
		}

	    public string LoadChildren(int id)
	    {
	        return JsonHelper.Instance.Serialize(_orgApp.LoadChildren(id));
	    }

        public void DelOrg(string json)
        {
            var delObj = JsonHelper.Instance.Deserialize<Org[]>(json);
            foreach (var obj in delObj)
            {
                _orgApp.DelOrg(obj.Id);
            }
           
        }
	}
}