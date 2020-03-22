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
    /// 数据权限控制
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class DataPrivilegeRulesController : ControllerBase
    {
        private readonly DataPrivilegeRuleApp _app;
        
        /// <summary>
        /// 获取数据权限详情
        /// </summary>
        /// <param name="id">数据权限id</param>
        /// <returns></returns>
        [HttpGet]
        public Response<DataPrivilegeRule> Get(string id)
        {
            var result = new Response<DataPrivilegeRule>();
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
        /// <summary>
        /// 添加数据权限
        /// </summary>
        /// <returns></returns>
       [HttpPost]
        public Response Add(AddOrUpdateDataPriviReq obj)
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

        /// <summary>
        /// 修改数据权限
        /// </summary>
        /// <returns></returns>
       [HttpPost]
        public Response Update(AddOrUpdateDataPriviReq obj)
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
        public TableData Load([FromQuery]QueryDataPrivilegeRuleListReq request)
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

        public DataPrivilegeRulesController(DataPrivilegeRuleApp app) 
        {
            _app = app;
        }
    }
}
