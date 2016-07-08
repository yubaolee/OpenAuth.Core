namespace OpenAuth.WebApi.Areas.SSO.Models.Services
{
    public class AppUserService : ServiceContext
    {
        public AppUser Get(string username = "")
        {
            //模拟用户
            return new AppUser
            {
                Nick = "超级管理员",
                UserName = username,
                UserPwd = "xxxxxxxxx"
            };
        }
    }
}