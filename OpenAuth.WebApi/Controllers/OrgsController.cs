using System;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.Repository.Domain;

namespace OpenAuth.WebApi.Controllers
{
    /// <summary>
    /// 机构操作
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class OrgsController : ControllerBase
    {
        private readonly OrgManagerApp _app;

        [HttpGet]
        public Response<Org> Get(string id)
        {
            var result = new Response<Org>();
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

        //添加或修改
        [HttpPost]
        public Response<Org> Add(Org obj)
        {
            var result = new Response<Org>();
            try
            {
                _app.Add(obj);
                result.Result = obj;
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
        public Response Update(Org obj)
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

        public OrgsController(OrgManagerApp app) 
        {
            _app = app;
        }
    }
}