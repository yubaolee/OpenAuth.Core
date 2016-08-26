using Infrastructure.Cache;
using System;
using System.Web;

namespace Infrastructure.Auth
{
    /// <summary>
    /// 身份认证服务实现(缓存可分布式部署)
    /// </summary>
    public class FormsAuthenticationService : IAuthenticationService
    {
        ICache cacheService;
        CacheSession cacheSession;
        HttpContext httpContext = HttpContext.Current;
        //hpf 缓存相关
        public FormsAuthenticationService()
        {
            cacheService = DIContainer.Resolve<ICache>();
            cacheSession = new CacheSession(httpContext, true);
        }
        /// <summary>
        /// 获取当前认证的用户
        /// </summary>
        /// <returns>当前用户未通过认证则返回null</returns>
        public dynamic GetAuthenticatedUser()
        {
            if (httpContext == null || !cacheSession.IsAuthenticated)
            {
                return null;//hpf未登录
            }
            return cacheService.Get<dynamic>(cacheSession.SessionId);
        }

        public void SignIn(string loginName, dynamic userInfo, TimeSpan expiration)
        {
            var sessionId = cacheSession.SessionId;
            cacheService.Set(sessionId, userInfo, expiration);
        }

        public void SignOut()
        {
            if (!string.IsNullOrEmpty(CacheKey.UserID))
            {
                cacheService.Remove(CacheKey.UserID);
            }
        }
    }
}
