using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using IdentityModel;
using IdentityServer4.Models;
using IdentityServer4.Services;
using IdentityServer4.Test;
using Microsoft.Extensions.Logging;
using OpenAuth.App;

namespace OpenAuth.IdentityServer
{
    public class CustomProfileService : IProfileService
    {
        /// <summary>
        /// The logger
        /// </summary>
        protected readonly ILogger Logger;

        protected UserManagerApp UserManager;

        /// <summary>
        /// Initializes a new instance of the <see cref="TestUserProfileService"/> class.
        /// </summary>
        /// <param name="users">The users.</param>
        /// <param name="logger">The logger.</param>
        public CustomProfileService( ILogger<TestUserProfileService> logger, UserManagerApp userManager)
        {
            Logger = logger;
            UserManager = userManager;
        }

        /// <summary>
        /// 只要有关用户的身份信息单元被请求（例如在令牌创建期间或通过用户信息终点），就会调用此方法
        /// </summary>
        /// <param name="context">The context.</param>
        /// <returns></returns>
        public virtual Task GetProfileDataAsync(ProfileDataRequestContext context)
        {
            context.LogProfileRequest(Logger);

            //判断是否有请求Claim信息
            if (context.RequestedClaimTypes.Any())
            {
                //根据用户唯一标识查找用户信息
                var user = UserManager.GetByAccount(context.Subject.Identity.Name);
               // var user = Users.FindBySubjectId(context.Subject.GetSubjectId());
                if (user != null)
                {
                    //调用此方法以后内部会进行过滤，只将用户请求的Claim加入到 context.IssuedClaims 集合中 这样我们的请求方便能正常获取到所需Claim
                    var claims = new[]
                    {
                        new Claim(JwtClaimTypes.Name, user.Account),
                        new Claim(JwtClaimTypes.GivenName, user.Name),
                        new Claim(JwtClaimTypes.WebSite, "http://openauth.me"),
                        new Claim(JwtClaimTypes.Address,
                            @"{ 'city':'CQ', 'postal_code': 40000, 'country': 'China' }",
                            IdentityServer4.IdentityServerConstants.ClaimValueTypes.Json)
                    };
                    context.AddRequestedClaims(claims);
                }
            }

            context.LogIssuedClaims(Logger);

            return Task.CompletedTask;
        }

        /// <summary>
        /// 验证用户是否有效 例如：token创建或者验证
        /// </summary>
        /// <param name="context">The context.</param>
        /// <returns></returns>
        public virtual Task IsActiveAsync(IsActiveContext context)
        {
            Logger.LogDebug("IsActive called from: {caller}", context.Caller);

              var user = UserManager.GetByAccount(context.Subject.Identity.Name);
            context.IsActive = user?.Status == 0;
            return Task.CompletedTask;
        }
    }
}
