using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using SqlSugar;

namespace OpenAuth.WebApi.Controllers
{
    /// <summary>
    /// 打印模板接口
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    [ApiExplorerSettings(GroupName = "打印模板接口_SysPrinterPlans")]
    public class SysPrinterPlansController : ControllerBase
    {
        private readonly SysPrinterPlanApp _app;
        
        //获取详情
        [HttpGet]
        public Response<SysPrinterPlan> Get(string id)
        {
            var result = new Response<SysPrinterPlan>();
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

        //添加
       [HttpPost]
        public Response<string> Add([FromBody] AddOrUpdateSysPrinterPlanReq obj)
        {
            var result = new Response<string>();
            try
            {
                result.Result=_app.Add(obj);

            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }
        
        /// <summary>
        /// 获取系统所有的表信息
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public Response<List<DbTableInfo>> GetTables()
        {
            var result = new Response<List<DbTableInfo>>();
            try
            {
                result.Result = _app.GetTables();
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }
        
        /// <summary>
        /// 按表名或视图名称获取列名
        /// </summary>
        /// <param name="tableViewName"></param>
        /// <returns></returns>
        [HttpGet]
        public Response<List<DbColumnInfo>> GetColumns(string tableViewName)
        {
            var result = new Response<List<DbColumnInfo>>();
            try
            {
                result.Result = _app.GetColumns(tableViewName);
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
        public Response Update([FromBody] AddOrUpdateSysPrinterPlanReq obj)
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
        public async Task<TableData> Load([FromQuery]QuerySysPrinterPlanListReq request)
        {
            return await _app.Load(request);
        }
        
        /// <summary>
        /// 打印方案根据数据源获取打印数据
        /// </summary>
        [HttpPost]
        public async Task<TableData> Query([FromBody] QueryReq request)
        {
            return await _app.Query(request);
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

        public SysPrinterPlansController(SysPrinterPlanApp app) 
        {
            _app = app;
        }
    }
}
