using Infrastructure;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using OpenAuth.App;

namespace OpenAuth.Mvc.Controllers
{
    /// <summary>
    /// 系统配置信息
    /// </summary>
    public class SysConfController : Controller
    {
        private IOptions<AppSetting> _appConfiguration;

        public SysConfController(IOptions<AppSetting> appConfiguration)
        {
            _appConfiguration = appConfiguration;
        }

        /// <summary>
        /// 是否Identity认证
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public string IsIdentityAuth()
        {
            var result = new Response<bool>
            {
                Result = _appConfiguration.Value.IsIdentityAuth
            };
            return JsonHelper.Instance.Serialize(result);
        }

    }
}
