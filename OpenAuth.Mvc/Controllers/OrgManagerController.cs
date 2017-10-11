using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using OpenAuth.Mvc.Models;
using System;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class OrgManagerController : BaseController
    {
        public OrgManagerApp OrgApp { get; set; }

        //
        // GET: /OrgManager/
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Assign(string firstId, string key)
        {
            ViewBag.FirstId = firstId;
            ViewBag.ModuleType = key;
            return View();
        }

        public string LoadForUser(string firstId)
        {
            var orgs = OrgApp.LoadForUser(firstId);
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string LoadForRole(string firstId)
        {
            var orgs = OrgApp.LoadForRole(firstId);
            return JsonHelper.Instance.Serialize(orgs);
        }


        //添加组织提交
        [HttpPost]
        public string AddOrg(Org org)
        {
            try
            {
                OrgApp.AddOrUpdate(org);
            }
            catch (Exception ex)
            {
                 Result.Status = false;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }
        
        public string LoadChildren(string id)
        {
            return JsonHelper.Instance.Serialize(OrgApp.LoadAllChildren(id));
        }

        /// <summary>
        /// 删除指定ID的组织
        /// <para>Id为逗号分开的字符串</para>
        /// </summary>
        /// <returns>System.String.</returns>
        [HttpPost]
        public string DelOrg(string[] ids)
        {
            try
            {
                OrgApp.DelOrg(ids);
            }
            catch (Exception e)
            {
                 Result.Status = false;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }
    }
}