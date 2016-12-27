using System;
using System.Web.Mvc;
using OpenAuth.App.SSO;

namespace OpenAuth.WebApi.Areas.SSO.Controllers
{

    /// <summary>
    ///  SSO自带的登录处理
    /// <para>第三方网站如果自己不开发登录界面，可直接跳转到本界面进行登录</para>
    /// </summary>
    public class LoginController : Controller
    {
        private AppInfoService _appInfoService;

        public LoginController()
        {
            _appInfoService = new AppInfoService();
        }

        private const string AppInfo = "AppInfo";

        //加载登录界面
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
            var result = SSOAuthUtil.Parse(model);

            if (result.Success)
            {
                var redirectUrl = string.Format("{0}?token={1}&sessionusername={2}", result.ReturnUrl, result.Token, model.UserName);

                //跳转默认回调页面
                return Redirect(redirectUrl);
            }

            TempData[AppInfo] = _appInfoService.Get(model.AppKey);
            return View(model);
        }
    }
}