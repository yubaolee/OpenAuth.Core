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
        private Response _response = new Response();

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

	    public ActionResult LookupParent()
	    {
	        return View();
	    }


		public string LoadOrg()
		{
		    return JsonHelper.Instance.Serialize(_orgApp.GetAll());
		}

	    public string LoadChildren(int id)
	    {
	        return JsonHelper.Instance.Serialize(_orgApp.LoadAllChildren(id));
	    }

        public string DelOrg(string json)
        {
            try
            {
                var delObj = JsonHelper.Instance.Deserialize<Org[]>(json);
                foreach (var obj in delObj)
                {
                    _orgApp.DelOrg(obj.Id);
                }
            }
            catch (Exception e)
            {
                _response.Status = false;
                _response.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(_response);

        }
	}
}