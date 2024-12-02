using System;
using System.Threading.Tasks;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.WebApi.Controllers
{
    /// <summary>
    /// 表单操作
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    [ApiExplorerSettings(GroupName = "表单_Forms")]
    public class FormsController : ControllerBase
    {
        private readonly FormApp _app;

        /// <summary>
        /// 获取表单
        /// </summary>
        /// <param name="id">表单ID</param>
        /// <param name="canWriteFormItemIds">针对动态表单项读写控制</param>
        /// <returns></returns>
        [HttpGet]
        public Response<FormResp> Get(string id, string canWriteFormItemIds)
        {
            var result = new Response<FormResp>();
            try
            {
                result.Result = _app.FindSingle(id);

                if (!string.IsNullOrEmpty(canWriteFormItemIds))
                {
                    result.Result.CanWriteFormItemIds = JsonHelper.Instance.Deserialize<string[]>(canWriteFormItemIds);
                }
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
        public Response Add([FromBody] Form obj)
        {
            var result = new Response();
            try
            {
                _app.Add(obj);

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
        public Response Update([FromBody] Form obj)
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

        /// <summary>
        /// 加载列表
        /// </summary>
        [HttpGet]
        public async Task<TableData> Load([FromQuery]QueryFormListReq request)
        {
            return await _app.Load(request);
        }

       [HttpPost]
        public Response Delete([FromBody]string[] ids)
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

        public FormsController(FormApp app) 
        {
            _app = app;
        }
    }
}