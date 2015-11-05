using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
	public class OrgManagerController : BaseController
	{
		private OrgManagerApp _orgApp;
        private BjuiResponse _bjuiResponse = new BjuiResponse();

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

        /// <summary>
        /// 选择上级机构页面
        /// </summary>
        /// <returns>ActionResult.</returns>
	    public ActionResult LookupParent()
	    {
	        return View();
	    }


	    public ActionResult AddOrg()
	    {
	        return View();
	    }

        //添加组织提交
        [HttpPost]
	    public string AddOrg(Org org)
        {
            try
            {
                _orgApp.AddOrg(org);
            }
            catch (Exception ex)
            {
                _bjuiResponse.statusCode = "300";
                _bjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(_bjuiResponse);

        }


		public string LoadOrg()
		{
		    return JsonHelper.Instance.Serialize(_orgApp.GetAll());
		}

	    public string LoadChildren(int id)
	    {
	        return JsonHelper.Instance.Serialize(_orgApp.LoadAllChildren(id));
	    }

        /// <summary>
        /// 删除指定ID的组织
        /// <para>Id为逗号分开的字符串</para>
        /// </summary>
        /// <returns>System.String.</returns>
        public string DelOrg(string Id)
        {
            try
            {
                
                foreach (var obj in Id.Split(','))
                {
                    _orgApp.DelOrg(int.Parse(obj));
                }
            }
            catch (Exception e)
            {
                _bjuiResponse.statusCode = "300";
                _bjuiResponse.message = e.Message;
            }

            return JsonHelper.Instance.Serialize(_bjuiResponse);

        }
	}
}