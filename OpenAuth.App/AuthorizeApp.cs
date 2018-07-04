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
        private readonly IUnitWork _unitWork;

        public AuthorizeApp(SystemAuthService sysService, AuthoriseService authoriseService, IUnitWork unitWork)
        {
            _systemAuth = sysService;
            _authoriseService = authoriseService;
            _unitWork = unitWork;
        }

        private AuthoriseService Create(string loginuser)
        {
            if (loginuser == "System")
            {
                return _systemAuth;
            }

            _authoriseService.User = _unitWork.FindSingle<User>(u => u.Account == loginuser);
            return _authoriseService;
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