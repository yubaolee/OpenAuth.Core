using System;
using System.Collections.Generic;
using System.Web.Http;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class RoleManagerController : BaseController
    {
        public RoleApp App { get; set; }

        //
        // GET: /UserManager/
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }

        //添加或修改组织
        [System.Web.Mvc.HttpPost]
        public string AddOrUpdate(RoleView view)
        {
            try
            {
                App.AddOrUpdate(view);

            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载组织下面的所有用户
        /// </summary>
        public string Load([FromUri]QueryRoleListReq request)
        {
            return JsonHelper.Instance.Serialize(App.Load(request));
        }

        [System.Web.Mvc.HttpPost]
        public string Delete(string[] ids)
        {
            try
            {
                App.Delete(ids);
            }
            catch (Exception e)
            {
                Result.Code = 500;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }
    }
}