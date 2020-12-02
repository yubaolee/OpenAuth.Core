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
    /// 分类（字典）管理
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CategorysController : ControllerBase
    {
        private readonly CategoryApp _app;
        
        /// <summary>
        /// 获取分类详情
        /// </summary>
        /// <param name="id">分类id</param>
        /// <returns></returns>
        [HttpGet]
        public Response<Category> Get(string id)
        {
            var result = new Response<Category>();
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
        /// 添加分类
        /// </summary>
        /// <returns></returns>
       [HttpPost]
        public Response Add(AddOrUpdateCategoryReq obj)
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
        /// 修改分类（字典）
        /// </summary>
        /// <returns></returns>
       [HttpPost]
        public Response Update(AddOrUpdateCategoryReq obj)
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
        public async Task<TableData> Load([FromQuery]QueryCategoryListReq request)
        {
            return await _app.Load(request);
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

        public CategorysController(CategoryApp app) 
        {
            _app = app;
        }
    }
}
