using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.WebApi.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class ResourcesController : ControllerBase
    {
        private readonly ResourceApp _app;

        public ResourcesController(IAuth authUtil, ResourceApp app) 
        {
            _app = app;
        }
        [HttpGet]
        public TableData Load([FromQuery]QueryResourcesReq request)
        {
            return _app.Load(request);
        }

       [HttpPost]
        public Response Delete(string[] ids)
        {
            Response resp = new Response();
            try
            {
                _app.Delete(ids);
            }
            catch (Exception e)
            {
                resp.Code = 500;
                resp.Message = e.Message;
            }
            return resp;
        }

       [HttpPost]
        public Response Add(Resource obj)
        {
            Response resp = new Response();
            try
            {
                _app.Add(obj);
            }
            catch (Exception e)
            {
                resp.Code = 500;
                resp.Message = e.Message;
            }
            return resp;
        }

       [HttpPost]
        public Response Update(Resource obj)
        {
            Response resp = new Response();
            try
            {
                _app.Update(obj);
            }
            catch (Exception e)
            {
                resp.Code = 500;
                resp.Message = e.Message;
            }
            return resp;
        }

    }
}