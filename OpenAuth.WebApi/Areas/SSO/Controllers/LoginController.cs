using System;
using System.Web.Mvc;
using Newtonsoft.Json;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.WebApi.Areas.SSO.Models;
using OpenAuth.WebApi.Areas.SSO.Models.Services;

namespace OpenAuth.WebApi.Areas.SSO.Controllers
{
    /// <summary>
    ///  公钥：AppKey
    ///  私钥：AppSecret
    ///  会话：Token
    /// </summary>
    public class LoginController : Controller
    {
        private readonly AppInfoService _appInfoService = new AppInfoService();
        private  UserManagerApp _useraApp = AutofacExt.GetFromFac<UserManagerApp>();
        private const string AppInfo = "AppInfo";

        //默认登录界面
        public ActionResult Index(string appKey = "", string username = "")
        {
            TempData[AppInfo] = _appInfoService.Get(appKey);

            var viewModel = new PassportLoginRequest
            {
                AppKey = appKey,
                UserName = username,
            };

            return View(viewModel);
        }

        //授权登录
        [HttpPost]
        public ActionResult Index(PassportLoginRequest model)
        {
            var result = Parse(model);

            if (result.Success)
            {
                var redirectUrl = string.Format("{0}?token={1}&sessionusername={2}", result.ReturnUrl, result.Token, model.UserName);

                //跳转默认回调页面
                return Redirect(redirectUrl);
            }

            return View(model);
        }

        [HttpPost]
        public string Check(PassportLoginRequest request)
        {
            return JsonConvert.SerializeObject(Parse(request));
        }

        [HttpPost]
        public bool Logout(string token, string requestid)
        {
            try
            {
                new UserAuthSessionService().Remove(token);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        private LoginResult Parse(PassportLoginRequest model)
        {
            //过滤字段无效字符
            model.Trim();

            var result = new LoginResult();

            try
            {
                //获取应用信息
                var appInfo = _appInfoService.Get(model.AppKey);
                if (appInfo == null)
                {
                    throw  new Exception("应用不存在");
                }
                TempData[AppInfo] = appInfo;

                //获取用户信息
                var userInfo = _useraApp.Get(model.UserName);
                if (userInfo == null)
                {
                    throw new Exception("用户不存在");
                }
                if (userInfo.Password != model.Password)
                {
                    throw new Exception("密码错误");
                }

                var currentSession = new UserAuthSession
                {
                    UserName = model.UserName,
                    Token = Guid.NewGuid().ToString().ToMd5(),
                    InvalidTime = DateTime.Now.AddMinutes(10),
                    AppKey = model.AppKey,
                    CreateTime = DateTime.Now,
                    IpAddress = Request.UserHostAddress
                };

                //创建Session
                new UserAuthSessionService().Create(currentSession);

                result.Success = true;
                result.ReturnUrl = appInfo.ReturnUrl;
                result.Token = currentSession.Token;
            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ErrorMsg = ex.Message;
            }

            return result;
        }
    }
}