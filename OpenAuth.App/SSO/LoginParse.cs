/*
 * 登录解析
 * 处理登录逻辑，验证客户段提交的账号密码，保存登录信息
 */
using System;
using Infrastructure;
using Infrastructure.Cache;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App.SSO
{
    public class LoginParse
    {

        //这个地方使用IRepository<User> 而不使用UserManagerApp是防止循环依赖
        public IRepository<SysUser,OpenAuthDBContext> _app;
        private ICacheContext _cacheContext;
        private AppManager _appInfoService;

        public LoginParse( AppManager infoService, ICacheContext cacheContext, IRepository<SysUser,OpenAuthDBContext> userApp)
        {
            _appInfoService = infoService;
            _cacheContext = cacheContext;
            _app = userApp;
        }

        public  LoginResult Do(PassportLoginRequest model)
        {
            var result = new LoginResult();
            try
            {
                model.Trim();
                //todo:如果需要判定应用，可以取消该注释
                // var appInfo = _appInfoService.GetByAppKey(model.AppKey);
                // if (appInfo == null)
                // {
                //     throw  new Exception("应用不存在");
                // }
                //获取用户信息
                SysUser sysUserInfo = null;
                if (model.Account == Define.SYSTEM_USERNAME)
                {
                    sysUserInfo = new SysUser
                    {
                        Id = Guid.Empty.ToString(), 
                        Account = Define.SYSTEM_USERNAME,
                        Name ="超级管理员",
                        Password = Define.SYSTEM_USERPWD
                    };
                }
                else
                {
                    sysUserInfo = _app.FirstOrDefault(u =>u.Account == model.Account);
                }
               
                if (sysUserInfo == null)
                {
                    throw new Exception("用户不存在");
                }
                if (sysUserInfo.Password != model.Password)
                {
                    throw new Exception("密码错误");
                }

                if (sysUserInfo.Status != 0)
                {
                    throw new Exception("账号状态异常，可能已停用");
                }

                var currentSession = new UserAuthSession
                {
                    Account = model.Account,
                    Name = sysUserInfo.Name,
                    Token = Guid.NewGuid().ToString().GetHashCode().ToString("x"),
                    AppKey = model.AppKey,
                    CreateTime = DateTime.Now
               //    , IpAddress = HttpContext.Current.Request.UserHostAddress
                };

                //创建Session
                _cacheContext.Set(currentSession.Token, currentSession, DateTime.Now.AddDays(10));

                result.Code = 200;
                result.Token = currentSession.Token;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }

            return result;
        }
    }
}