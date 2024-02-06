﻿using System;
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
    /// 代码生成器表字段结构
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    [ApiExplorerSettings(GroupName = "代码生成器_字段_BuilderTableColumns")]
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
        /// 同步数据结构
        /// <para>读取数据库结构与当前结构的差异，如果数据库有新增的字段，则自动加入</para>
        /// </summary>
        [HttpPost]
        public Response Sync(SyncStructureReq obj)
        {
            var result = new Response();
            try
            {
                _app.Sync(obj);

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
        public async Task<TableResp<BuilderTableColumn>> Load([FromQuery]QueryBuilderTableColumnListReq request)
        {
            var tableResp = await _app.Load(request);
            return tableResp;
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
