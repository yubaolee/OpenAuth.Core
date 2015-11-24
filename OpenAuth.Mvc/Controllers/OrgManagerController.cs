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
        private OrgManagerApp _orgApp;
       

        public OrgManagerController()
        {
            _orgApp = (OrgManagerApp)DependencyResolver.Current.GetService(typeof(OrgManagerApp));
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

        public ActionResult LookupMulti()
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
                _orgApp.AddOrUpdate(org);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        public string EditOrg(string json)
        {
            try
            {
                var org = JsonHelper.Instance.Deserialize<Org>(json);
                _orgApp.AddOrUpdate(org);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        public string LoadOrg()
        {
            var orgs = _orgApp.GetAll();
           //添加根节点
            orgs.Add(new Org
            {
                Id = 0,
                ParentId = -1,
                Name = "全部机构",
                CascadeId = "0"
            });
            return JsonHelper.Instance.Serialize(orgs);
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
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = e.Message;
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }
    }
}