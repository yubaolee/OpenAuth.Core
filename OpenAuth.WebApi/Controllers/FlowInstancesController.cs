using System;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.WebApi.Controllers
{
    /// <summary>
    /// 流程实例
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class FlowInstancesController : ControllerBase
    {
        private readonly FlowInstanceApp _app;

        [HttpGet]
        public Response<FlowVerificationResp> Get(string id)
        {
            var result = new Response<FlowVerificationResp>();
            try
            {
                var flowinstance = _app.Get(id);
                result.Result = flowinstance.MapTo<FlowVerificationResp>();
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }

        //添加或修改
       [HttpPost]
        public Response Add(JObject obj)
        {
            var result = new Response();
            try
            {
                _app.CreateInstance(obj);

            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }

        //添加或修改
       [HttpPost]
        public Response Update(FlowInstance obj)
        {
            var result = new Response();
            try
            {
                _app.Update(obj);

            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }

        [HttpPost]
        public Response Verification(VerificationReq request)
        {
            var response = new Response();
            try
            {
                _app.Verification(request);

            }
            catch (Exception ex)
            {
                response.Code = 500;
                response.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return response;
        }

        /// <summary>
        /// 加载列表
        /// </summary>
        [HttpGet]
        public TableData Load([FromQuery]QueryFlowInstanceListReq request)
        {
            return _app.Load(request);
        }

       [HttpPost]
        public Response Delete(string[] ids)
        {
            var result = new Response();
            try
            {
                _app.Delete(ids);

            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }

        public FlowInstancesController(FlowInstanceApp app) 
        {
            _app = app;
        }
    }
}