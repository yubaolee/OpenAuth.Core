using System.Linq;
using Infrastructure;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    ///  加载用户所有可访问的资源/机构/模块
    /// <para>李玉宝新增于2016-07-19 10:53:30</para>
    /// </summary>
    public class AuthorizeApp
    {
        private SystemAuthService _systemAuth;
        private AuthoriseService _authoriseService;

        public AuthorizeApp(SystemAuthService sysService, AuthoriseService authoriseService)
        {
            _systemAuth = sysService;
            _authoriseService = authoriseService;
        }

        public IUnitWork _unitWork { get; set; }
        private AuthoriseService Create(string loginuser)
        {
            if (loginuser == "System")
            {
                return _systemAuth;
            }
            else
            {
                _authoriseService.User = _unitWork.FindSingle<User>(u => u.Account == loginuser);
                return _authoriseService;
            }
        }

        public UserWithAccessedCtrls GetAccessedControls(string username)
        {
            var service = Create(username);
            var user = new UserWithAccessedCtrls
            {
                User = service.User,
                Orgs = service.Orgs,
                Modules = service.Modules,
                Resources = service.Resources,
                Roles = service.Roles
            };
            
            return user;
        }
    }
}