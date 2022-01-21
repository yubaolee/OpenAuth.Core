using Infrastructure;
using OpenAuth.App;
using System;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App.Interface;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Mvc.Controllers
{
    public class OrgManagerController : BaseController
    {
        private OrgManagerApp _orgApp;
        public OrgManagerController(IAuth authUtil, OrgManagerApp orgApp) : base(authUtil)
        {
            _orgApp = orgApp;
        }

        //
        // GET: /OrgManager/
       
        public ActionResult Index()
        {
            return View();
        }
       
        /// <summary>
        /// 获取用户所能访问的部门
        /// </summary>
        public string LoadForUser(string firstId)
        {
            var orgs = _orgApp.LoadForUser(firstId);
            return JsonHelper.Instance.Serialize(orgs);
        }

        //添加组织提交
        [HttpPost]
        public string Add(SysOrg sysOrg)
        {
            try
            {
                _orgApp.Add(sysOrg);
            }
            catch (Exception ex)
            {
                  Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        //编辑
        [HttpPost]
        public string Update(SysOrg sysOrg)
        {
            try
            {
                _orgApp.Update(sysOrg);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

       /// <summary>
        /// 删除指定ID的组织
        /// </summary>
        /// <returns>System.String.</returns>
        [HttpPost]
        public string Delete(string[] ids)
        {
            try
            {
                _orgApp.DelOrgCascade(ids);
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