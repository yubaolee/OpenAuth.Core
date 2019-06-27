using System;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Mvc.Controllers
{
    public class FormsController : BaseController
    {
        private readonly FormApp _app;

        //
       
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Preview()
        {
            return View();
        }

        public ActionResult Edit()
        {
            return View();
        }

        public string Get(string id)
        {
            try
            {
                var result = new Response<FormResp>
                {
                    Result = _app.FindSingle(id)
                };
                return JsonHelper.Instance.Serialize(result);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
                return JsonHelper.Instance.Serialize(Result);
            }
        }

        //添加或修改
       [HttpPost]
       
        public string Add(Form obj)
        {
            try
            {
                _app.Add(obj);

            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        //添加或修改
       [HttpPost]
       
        public string Update(Form obj)
        {
            try
            {
                _app.Update(obj);

            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载列表
        /// </summary>
        public string Load([FromQuery]QueryFormListReq request)
        {
            return JsonHelper.Instance.Serialize(_app.Load(request));
        }

       [HttpPost]
        public string Delete(string[] ids)
        {
            try
            {
                _app.Delete(ids);
            }
            catch (Exception e)
            {
                Result.Code = 500;
                Result.Message = e.InnerException?.Message ?? e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }

        public FormsController(IAuth authUtil, FormApp app) : base(authUtil)
        {
            _app = app;
        }
    }
}