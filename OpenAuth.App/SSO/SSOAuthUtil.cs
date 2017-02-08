using System;
using System.Web;
using System.Web.Mvc;
using Infrastructure;
using Infrastructure.Cache;
using OpenAuth.Domain;



namespace OpenAuth.App.SSO
{
    public class SSOAuthUtil
    {
        public static  LoginResult Parse(PassportLoginRequest model)
        {
            var result = new LoginResult();
            try
            {
                model.Trim();
                //获取应用信息
                var appInfo = new AppInfoService().Get(model.AppKey);
                if (appInfo == null)
                {
                    throw  new Exception("应用不存在");
                }
                //获取用户信息
                User userInfo = null;
                if (model.UserName == "System")
                {
                    userInfo = new User
                    {
                        Id = Guid.Empty,
                        Account = "System",
                        Name ="超级管理员",
                        Password = "123456"
                    };
                }
                else
                {
                    var usermanager = (UserManagerApp)DependencyResolver.Current.GetService(typeof(UserManagerApp));
                    userInfo = usermanager.Get(model.UserName);
                }
               
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
                    Token = Guid.NewGuid().ToString().GetHashCode().ToString("x"),
                    AppKey = model.AppKey,
                    CreateTime = DateTime.Now,
                    IpAddress = HttpContext.Current.Request.UserHostAddress
                };

                //创建Session
                new ObjCacheProvider<UserAuthSession>().Create(currentSession.Token, currentSession, DateTime.Now.AddDays(10));

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