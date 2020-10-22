using Infrastructure;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using OpenAuth.App;

namespace OpenAuth.WebApi.Controllers
{
    /// <summary>
    /// 系统配置信息
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class SysConfController :ControllerBase
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
        [HttpGet]
        public Response<bool> IsIdentityAuth()
        {
            return new Response<bool>
            {
                Result = _appConfiguration.Value.IsIdentityAuth
            };
        }
    }
}
