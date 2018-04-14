using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.Request;
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
        public ActionResult Assign()
        {
            return View();
        }

        /// <summary>
        /// 加载特定用户的资源
        /// </summary>
        /// <param name="appId">应用appId</param>
        /// <param name="firstId">用户ID</param>
        /// <returns>System.String.</returns>
        public string LoadForUser(string appId, string firstId)
        {

            try
            {
                var result = new Response<List<string>>
                {
                    Result = App.LoadForUser(appId, firstId).Select(u  =>u.Id).ToList()
            };
                return JsonHelper.Instance.Serialize(result);
            }
            catch (Exception e)
            {
                Result.Code = 500;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载角色资源
        /// </summary>
        /// <param name="appId">应用ID</param>
        /// <param name="firstId">角色ID</param>
        public string LoadForRole(string appId, string firstId)
        {
            try
            {
                var result = new Response<List<string>>
                {
                    Result = App.LoadForRole(appId, firstId).Select(u => u.Id).ToList()
                };
                return JsonHelper.Instance.Serialize(result);
            }
            catch (Exception e)
            {
                Result.Code = 500;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
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