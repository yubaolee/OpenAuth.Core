using System;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Mvc.Controllers
{
    public class ApplicationsController : BaseController
    {
        private readonly AppManager _app;


        public string GetList([FromQuery]QueryAppListReq request)
        {
            return JsonHelper.Instance.Serialize(_app.GetList(request));
        }

       [HttpPost]
        public string Delete(string[] ids)
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
            return JsonHelper.Instance.Serialize(resp);
        }

       [HttpPost]
        public string Add(Application obj)
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
            return JsonHelper.Instance.Serialize(resp);
        }

       [HttpPost]
        public string Update(Application obj)
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
            return JsonHelper.Instance.Serialize(resp);
        }


        public ApplicationsController(AuthUtil authUtil, AppManager app) : base(authUtil)
        {
            _app = app;
        }
    }
}