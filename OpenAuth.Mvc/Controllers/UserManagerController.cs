using System;
using System.Collections.Generic;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;

namespace OpenAuth.Mvc.Controllers
{
    public class UserManagerController : BaseController
    {
        private readonly UserManagerApp _app;
        public UserManagerController(IAuth authUtil, UserManagerApp app) : base(authUtil)
        {
            _app = app;
        }
        //
        // GET: /UserManager/
       
        public ActionResult Index()
        {
            return View();
        }
        
        public ActionResult Profile()
        {
            return View();
        }

        public ActionResult ChangePassword()
        {
            return View();
        }
        
        /// <summary>
        /// 修改用户资料
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost]
        public string ChangeProfile(ChangeProfileReq request)
        {
            try
            {
                _app.ChangeProfile(request);
                Result.Message = "修改成功，重新登录生效";
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost]
        public string ChangePassword(ChangePasswordReq request)
        {
            try
            {
                _app.ChangePassword(request);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        //添加或修改组织
        [HttpPost]
        public string AddOrUpdate(UpdateUserReq request)
        {
            try
            {
                _app.AddOrUpdate(request);

            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.InnerException?.Message ?? ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载组织下面的所有用户
        /// </summary>
        public string Load([FromQuery]QueryUserListReq request)
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

        #region 获取权限数据

        /// <summary>
        /// 获取用户可访问的账号
        /// <para>李玉宝于2017-02-28 15:12:19</para>
        /// </summary>
        public string GetAccessedUsers()
        {
            IEnumerable<UserView> users = _app.Load(new QueryUserListReq()).data;
            var result = new Dictionary<string, object>();
            foreach (var user in users)
            {
                var item = new
                {
                    Account = user.Account,
                    RealName = user.Name,
                    id = user.Id,
                    text = user.Name,
                    value = user.Account,
                    parentId = "0",
                    showcheck = true,
                    img = "fa fa-user",
                };
                result.Add(user.Id, item);
            }

            return JsonHelper.Instance.Serialize(result);
        }
        #endregion

    }
}