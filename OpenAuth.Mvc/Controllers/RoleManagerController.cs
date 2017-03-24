using Infrastructure;
using OpenAuth.App;
using System;
using System.Web.Http;
using System.Web.Mvc;
using Newtonsoft.Json.Linq;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class RoleManagerController : BaseController
    {
        public RoleManagerApp App { get; set; }

        //
        // GET: /RoleManager/
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }

        //添加或修改角色
        [System.Web.Mvc.HttpPost]
        public string Add([FromBody]JObject obj)
        {
            try
            {
                App.AddOrUpdate(obj);
            }
            catch (Exception ex)
            {
                 Result.Status = false;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载角色下面的所有用户
        /// </summary>
        public string Load(Guid orgId, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(App.Load(orgId, pageCurrent, pageSize));
        }

        [System.Web.Mvc.HttpPost]
        public string Delete(Guid[] ids)
        {
            try
            {
                foreach (var obj in ids)
                {
                    App.Delete(obj);
                }
            }
            catch (Exception e)
            {
                 Result.Status = false;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }

        #region 为用户设置角色界面
        public ActionResult LookupMulti(Guid firstId, string key)
        {
            ViewBag.FirstId = firstId;
            ViewBag.ModuleType = key;
            return View();
        }

        public string LoadForOrgAndUser(Guid orgId, Guid userId)
        {
            return JsonHelper.Instance.Serialize(App.LoadForOrgAndUser(orgId, userId));
        }

        #endregion 为用户设置角色界面
    }
}