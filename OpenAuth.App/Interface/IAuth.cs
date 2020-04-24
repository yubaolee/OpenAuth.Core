/*
 *单独提取这个接口，为了以下几点：
 * 1、可以方便的实现webapi 和本地登录相互切换
 * 2、可以方便的使用mock进行单元测试
 */

using OpenAuth.App.SSO;

namespace OpenAuth.App.Interface
{
    public interface IAuth
    {
        /// <summary>
        /// 检验token是否有效
        /// </summary>
        /// <param name="token">token值</param>
        /// <param name="otherInfo"></param>
        /// <returns></returns>
        bool CheckLogin(string token="", string otherInfo = "");
        AuthStrategyContext GetCurrentUser();
        string GetUserName(string otherInfo = "");
        /// <summary>
        /// 登录接口
        /// </summary>
        /// <param name="appKey">登录的应用appkey</param>
        /// <param name="username">用户名</param>
        /// <param name="pwd">密码</param>
        /// <returns></returns>
        LoginResult Login(string appKey, string username, string pwd);
        /// <summary>
        /// 退出登录
        /// </summary>
        /// <returns></returns>
        bool Logout();
    }
}
