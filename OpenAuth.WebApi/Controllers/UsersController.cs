using System;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.App.Response;

namespace OpenAuth.WebApi.Controllers
{
    /// <summary>
    /// 用户操作
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly UserManagerApp _app;

        [HttpGet]
        public Response<UserView> Get(string id)
        {
            var result = new Response<UserView>();
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
        /// 修改用户资料
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost]
        public Response ChangeProfile(ChangeProfileReq request)
        {
            var result = new Response();
            
            try
            {
                _app.ChangeProfile(request);
                result.Message = "修改成功，重新登录生效";
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost]
        public Response ChangePassword(ChangePasswordReq request)
        {
            var result = new Response();
            try
            {
                _app.ChangePassword(request);
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
        public Response<string> AddOrUpdate(UpdateUserReq obj)
        {
            var result = new Response<string>();
            try
            {
                _app.AddOrUpdate(obj);
                result.Result = obj.Id;   //返回ID
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
        public TableData Load([FromQuery]QueryUserListReq request)
        {
            return _app.Load(request);
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

        /// <summary>
        /// 加载指定角色的用户
        /// </summary>
        [HttpGet]
        public TableData LoadByRole([FromQuery]QueryUserListByRoleReq request)
        {
            return _app.LoadByRole(request);
        }
        
        public UsersController(UserManagerApp app) 
        {
            _app = app;
        }
    }
}