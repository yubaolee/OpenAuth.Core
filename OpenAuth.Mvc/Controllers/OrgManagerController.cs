using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using OpenAuth.Mvc.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Infrastructure.Helper;
using OpenAuth.App.ViewModel;

namespace OpenAuth.Mvc.Controllers
{
    public class OrgManagerController : BaseController
    {
        private OrgManagerApp _orgApp;

        public OrgManagerController()
        {
            _orgApp = AutofacExt.GetFromFac<OrgManagerApp>();
        }

        //
        // GET: /OrgManager/
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Assign(int firstId, string key)
        {
            ViewBag.FirstId = firstId;
            ViewBag.ModuleType = key;
            return View();
        }

        public string LoadOrg()
        {
            return JsonHelper.Instance.Serialize(AutofacExt.GetFromFac<LoginApp>().GetLoginUser().AccessedOrgs);
        }

        public string LoadForUser(int firstId)
        {
            var orgs = _orgApp.LoadForUser(firstId);
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string LoadForRole(int firstId)
        {
            var orgs = _orgApp.LoadForRole(firstId);
            return JsonHelper.Instance.Serialize(orgs);
        }


        //添加组织提交
        [HttpPost]
        public string AddOrg(Org org)
        {
            try
            {
                _orgApp.AddOrUpdate(org);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
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
        public string DelOrg(int Id)
        {
            try
            {
                _orgApp.DelOrg(Id);
            }
            catch (Exception e)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = e.Message;
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }
    }
}