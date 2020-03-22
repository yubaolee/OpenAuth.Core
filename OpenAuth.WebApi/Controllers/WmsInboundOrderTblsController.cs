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
    /// 订单头部信息
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class WmsInboundOrderTblsController : ControllerBase
    {
        private readonly WmsInboundOrderTblApp _app;
        
        //获取详情
        [HttpGet]
        public Response<WmsInboundOrderTbl> Get(string id)
        {
            var result = new Response<WmsInboundOrderTbl>();
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
        /// 新增订单，可以同时添加头/明细，也可以只添加头，根据返回的ID再添加明细
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
       [HttpPost]
        public Response Add(AddOrUpdateWmsInboundOrderTblReq obj)
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
       /// 修改头信息,同时修改明细信息
       /// 如果提交的明细有id，则编辑；
       /// 如果提交的明细没有id，则添加;
       /// 如果数据库中存在没有提交的明细，则删除数据库中记录
       /// </summary>
       /// <param name="obj"></param>
       /// <returns></returns>
       [HttpPost]
        public Response Update(AddOrUpdateWmsInboundOrderTblReq obj)
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
        public TableData Load([FromQuery]QueryWmsInboundOrderTblListReq request)
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

        public WmsInboundOrderTblsController(WmsInboundOrderTblApp app) 
        {
            _app = app;
        }
    }
}
