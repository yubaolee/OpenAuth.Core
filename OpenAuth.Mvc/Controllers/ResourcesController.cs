using System;
using System.Web.Http;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Mvc.Controllers
{
    public class ResourcesController : BaseController
    {
        public ResourceApp App { get; set; }

        //
        // GET: /UserManager/
        public ActionResult Index()
        {
            return View();
        }

        public string Load([FromUri]QueryResourcesReq request)
        {
            return JsonHelper.Instance.Serialize(App.Load(request));
        }

        [System.Web.Mvc.HttpPost]
        public string Delete(string[] ids)
        {
            Response resp = new Response();
            try
            {
                App.Delete(ids);
            }
            catch (Exception e)
            {
                resp.Code = 500;
                resp.Message = e.Message;
            }
            return JsonHelper.Instance.Serialize(resp);
        }

        [System.Web.Mvc.HttpPost]
        public string Add(Resource obj)
        {
            Response resp = new Response();
            try
            {
                App.Add(obj);
            }
            catch (Exception e)
            {
                resp.Code = 500;
                resp.Message = e.Message;
            }
            return JsonHelper.Instance.Serialize(resp);
        }

        [System.Web.Mvc.HttpPost]
        public string Update(Resource obj)
        {
            Response resp = new Response();
            try
            {
                App.Update(obj);
            }
            catch (Exception e)
            {
                resp.Code = 500;
                resp.Message = e.Message;
            }
            return JsonHelper.Instance.Serialize(resp);
        }


    }
}