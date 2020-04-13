using System;
using System.Collections.Generic;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Mvc.Controllers
{
    public class FlowInstancesController : BaseController
    {
        private readonly FlowInstanceApp _app;
        public FlowInstancesController(IAuth authUtil, FlowInstanceApp app) : base(authUtil)
        {
            _app = app;
        }

        //
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 待处理的流程
        /// </summary>
        public ActionResult Wait()
        {
            return View();
        }

        /// <summary>
        /// 已完成的流程
        /// </summary>
        public ActionResult Disposed()
        {
            return View();
        }

        /// <summary>
        /// 编辑
        /// </summary>
        /// <returns></returns>
        public ActionResult Edit()
        {
            return View();
        }

        /// <summary>
        /// 进度详情
        /// </summary>
        /// <returns></returns>
        public ActionResult Detail()
        {
            return View();
        }

        public ActionResult Verification()
        {
            return View();
        }

        [HttpPost]
        public string Verification(VerificationReq request)
        {
            try
            {
                _app.Verification(request);

            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        public string Get(string id)
        {
            try
            {
                var flowinstance = _app.Get(id);

                var result = new Response<FlowVerificationResp>
                {
                    Result = flowinstance.MapTo<FlowVerificationResp>()
                };
                return JsonHelper.Instance.Serialize(result);
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
       
        public string Add(AddFlowInstanceReq obj)
        {
            try
            {
                _app.CreateInstance(obj);
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
        public string Update(FlowInstance obj)
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
        public string Load([FromQuery]QueryFlowInstanceListReq request)
        {
            return JsonHelper.Instance.Serialize(_app.Load(request));
        }

        /// <summary>
        /// 获取一个流程实例的操作历史记录
        /// </summary>
        [HttpGet]
        public string QueryHistories([FromQuery]QueryFlowInstanceHistoryReq request)
        {
            var result = new Response<List<FlowInstanceOperationHistory>>();
            try
            {
                result.Result = _app.QueryHistories(request);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return JsonHelper.Instance.Serialize(result);
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

    }
}