
using System;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;

namespace OpenAuth.WebApi.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class AccessObjsController : ControllerBase
    {
        private readonly RevelanceManagerApp _app;
        private readonly IAuth _authUtil;
        public AccessObjsController(IAuth authUtil, RevelanceManagerApp app) 
        {
            _app = app;
            _authUtil = authUtil;
        }

        /// <summary>
        /// 比如给用户分配资源，那么firstId就是用户ID，secIds就是资源ID列表
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public Response Assign(AssignReq request)
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

            return result;
        }
        [HttpPost]
        public Response UnAssign(AssignReq request)
        {
            var result = new Response();
            try
            {
                _app.UnAssign(request.type, request.firstId, request.secIds);
            }
            catch (Exception ex)
            {
                  result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }

       
    }
}