using System;
using System.Collections.Generic;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.App.SSO;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class RoleManagerController : BaseController
    {
        private readonly RoleApp _app;
        private readonly RevelanceManagerApp _revelanceManagerApp;
        public RoleManagerController(IAuth authUtil, RevelanceManagerApp revelanceManagerApp, RoleApp app) : base(authUtil)
        {
            _revelanceManagerApp = revelanceManagerApp;
            _app = app;
        }
        //
        // GET: /UserManager/
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Assign()
        {
            return View();
        }

        //添加或修改组织
       [HttpPost]
        public string Add(RoleView obj)
        {
            try
            {
                _app.Add(obj);

            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        //添加或修改组织
       [HttpPost]
        public string Update(RoleView obj)
        {
            try
            {
                _app.Update(obj);

            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载用户的角色
        /// </summary>
        public string LoadForUser(string userId)
        {
            try
            {
                var result = new Response<List<string>>
                {
                    Result = _revelanceManagerApp.Get(Define.USERROLE, true, userId)
                };
                return JsonHelper.Instance.Serialize(result);
            }
            catch (Exception e)
            {
                Result.Code = 500;
                Result.Message = e.InnerException?.Message ?? e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载组织下面的所有用户
        /// </summary>
        public string Load([FromQuery]QueryRoleListReq request)
        {
            return JsonHelper.Instance.Serialize(_app.Load(request));
        }

       [HttpPost]
        public string Delete(string[] ids)
        {
            try
            {
                _app.Delete(ids);
            }
            catch (Exception e)
            {
                Result.Code = 500;
                Result.Message = e.InnerException?.Message ?? e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }

    }
}