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
    /// 代码生成器相关操作
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class BuilderTablesController : ControllerBase
    {
        private readonly BuilderTableApp _app;
        
        /// <summary>
        /// 创建一个代码生成的模版
        /// <para>会自动创建字段明细信息，添加成功后使用BuilderTableColumnsController.Load加载字段明细</para>
        /// <returns>返回添加的模版ID</returns>
        /// </summary>
       [HttpPost]
        public Response<string> Add(AddOrUpdateBuilderTableReq obj)
        {
            var result = new Response<string>();
            try
            {
                result.Result = _app.Add(obj);

            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }

        /// <summary>
        /// 只修改表信息，不会更新明细
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
       [HttpPost]
        public Response Update(AddOrUpdateBuilderTableReq obj)
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
        public TableResp<BuilderTable> Load([FromQuery]QueryBuilderTableListReq request)
        {
            return _app.Load(request);
        }

        /// <summary>
        /// 批量删除代码生成模版和对应的字段信息
        /// </summary>
       [HttpPost]
        public Response Delete([FromBody]string[] ids)
        {
            var result = new Response();
            try
            {
                _app.DelTableAndcolumns(ids);

            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }
        
        /// <summary>
        /// 创建实体
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        [HttpPost]
        public Response CreateEntity(CreateEntityReq obj)
        {
            var result = new Response();
            try
            {
                _app.CreateEntity(obj);

            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }
        
        /// <summary>
        /// 创建业务逻辑层
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        [HttpPost]
        public Response CreateBusiness(CreateBusiReq obj)
        {
            var result = new Response();
            try
            {
                _app.CreateBusiness(obj);

            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }
        
        /// <summary>
        /// 创建vue界面
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        [HttpPost]
        public Response CreateVue(CreateVueReq obj)
        {
            var result = new Response();
            try
            {
                _app.CreateVue(obj);
                _app.CreateVueApi(obj);

            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }

        public BuilderTablesController(BuilderTableApp app) 
        {
            _app = app;
        }
    }
}
