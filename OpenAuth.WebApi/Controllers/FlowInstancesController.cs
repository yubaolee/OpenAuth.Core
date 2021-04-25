// <copyright file="FlowInstancesController.cs" company="openauth.me">
// Copyright (c) 2019 openauth.me. All rights reserved.
// </copyright>
// <author>www.cnblogs.com/yubaolee</author>
// <date>2018-09-06</date>
// <summary>流程实例控制器</summary>

using System;
using System.Collections.Generic;
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
    /// 流程实例
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class FlowInstancesController : ControllerBase
    {
        private readonly FlowInstanceApp _app;

        [HttpGet]
        public Response<FlowVerificationResp> Get(string id)
        {
            var result = new Response<FlowVerificationResp>();
            try
            {
                result.Result = _app.GetForVerification(id);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }

        /// <summary>
        /// 获取一个流程实例的操作历史记录
        /// </summary>
        [HttpGet]
        public Response<List<FlowInstanceOperationHistory>> QueryHistories([FromQuery]QueryFlowInstanceHistoryReq request)
        {
            var result = new Response<List<FlowInstanceOperationHistory>>();
            try
            {
                result.Result= _app.QueryHistories(request);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }


        /// <summary>创建一个新的流程实例</summary>
        /// <remarks> www.cnblogs.com/yubaolee, 2019-03-06. </remarks>
        [HttpPost]
        public Response Add([FromBody]AddFlowInstanceReq obj)
        {
            var result = new Response();
            try
            {
                _app.CreateInstance(obj);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }
        
        /// <summary>召回流程</summary>
        /// <remarks> 召回后流程状态为【草稿】状态，可以再次发起流程。所有的流程节点状态还原，但保留审批记录 </remarks>
        [HttpPost]
        public Response ReCall(RecallFlowInstanceReq obj)
        {
            var result = new Response();
            try
            {
                _app.ReCall(obj);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }
        
        /// <summary>启动流程</summary>
        /// <remarks> 通常是对状态为【草稿】的流程进行操作，进入运行状态 </remarks>
        [HttpPost]
        public Response Start(StartFlowInstanceReq obj)
        {
            var result = new Response();
            try
            {
                _app.Start(obj);
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
        public Response Update(FlowInstance obj)
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
        /// 流程节点审批
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public Response Verification(VerificationReq request)
        {
            var response = new Response();
            try
            {
                _app.Verification(request);

            }
            catch (Exception ex)
            {
                response.Code = 500;
                response.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return response;
        }

        /// <summary>
        /// 加载列表
        /// </summary>
        [HttpGet]
        public async Task<TableData> Load([FromQuery]QueryFlowInstanceListReq request)
        {
            return await _app.Load(request);
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

        public FlowInstancesController(FlowInstanceApp app) 
        {
            _app = app;
        }
    }
}