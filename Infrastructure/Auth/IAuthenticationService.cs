using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Auth
{
    /// <summary>
    /// 用于身份认证接口
    /// </summary>
    public interface IAuthenticationService
    {
        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="loginName">登录名</param>
        /// <param name="userData">与登录名相关的用户信息</param>
        /// <param name="expiration">登录Cookie的过期时间，单位：分钟。</param>
        void SignIn(string loginName, dynamic userInfo, TimeSpan expiration);
        /// <summary>
        /// 注销
        /// </summary>
        void SignOut();
        /// <summary>
        /// 获取当前登录的用户
        /// </summary>
        /// <returns>当前用户未通过认证则返回null</returns>
        dynamic GetAuthenticatedUser();
    }
}
