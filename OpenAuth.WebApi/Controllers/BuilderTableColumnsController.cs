using System;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.WebApi.Controllers
{
    /// <summary>
    /// 代码生成器表字段结构
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class BuilderTableColumnsController : ControllerBase
    {
        private readonly BuilderTableColumnApp _app;
        
        //获取详情
        [HttpGet]
        public Response<BuilderTableColumn> Get(string id)
        {
            var result = new Response<BuilderTableColumn>();
            try
            {
                result.Result = _app.Get(id);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }
        

        //修改
       [HttpPost]
        public Response Update(AddOrUpdateBuilderTableColumnReq obj)
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
        public TableResp<BuilderTableColumn> Load([FromQuery]QueryBuilderTableColumnListReq request)
        {
            return _app.Load(request);
        }

        /// <summary>
        /// 批量删除
        /// </summary>
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

        public BuilderTableColumnsController(BuilderTableColumnApp app) 
        {
            _app = app;
        }
    }
}
