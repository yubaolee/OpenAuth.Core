using System;
using System.Web.Http;
using System.Web.Mvc;
using Infrastructure;
using LwSolution.App;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Mvc.Controllers
{
    public class CategoriesController : BaseController
    {
        public CategoryApp App { get; set; }

        //
        // GET: /UserManager/
        public ActionResult Index()
        {
            return View();
        }

        public string All([FromUri]QueryCategoriesReq request)
        {
            TableData data = new TableData();
            data = App.All(request);
            return JsonHelper.Instance.Serialize(data);
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
        public string Add(Category obj)
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
        public string Update(Category obj)
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

        //所有得分类类型
        public string AllTypes()
        {
            var data = App.AllTypes();
            return JsonHelper.Instance.Serialize(data);
        }

    }
}