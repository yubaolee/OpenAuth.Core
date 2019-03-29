using System;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;

namespace OpenAuth.Mvc.Controllers
{
    public class RelevanceManagerController : BaseController
    {
        private readonly RevelanceManagerApp _app;

        public RelevanceManagerController(IAuth authUtil, RevelanceManagerApp app) : base(authUtil)
        {
            _app = app;
        }

        [HttpPost]
        public string Assign(AssignReq request)
        {
            var result = new Response();
            try
            {
                _app.Assign(request);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return JsonHelper.Instance.Serialize(result);
        }

        /// <summary>
        /// 角色分配数据字段权限
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public string AssignDataProperty(AssignDataReq request)
        {
            var result = new Response();
            try
            {
                _app.AssignData(request);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return JsonHelper.Instance.Serialize(result);
        }

        [HttpPost]
        public string UnAssign(string type, string firstId, string[] secIds)
        {
            try
            {
                _app.UnAssign(type, firstId, secIds);
            }
            catch (Exception ex)
            {
                  Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

                /// <summary>
        /// 取消角色的数据字段权限
        /// <para>如果Properties为空，则把角色的某一个模块权限全部删除</para>
        /// <para>如果moduleId为空，直接把角色的所有授权删除</para>
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost]
        public string UnAssignDataProperty(AssignDataReq request)
        {
            var result = new Response();
            try
            {
                _app.UnAssignData(request);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

             return JsonHelper.Instance.Serialize(Result);
        }

       
    }
}