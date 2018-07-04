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
        private SystemAuthStrategy _systemAuth;
        private NormalAuthStrategy _normalAuthStrategy;
        private readonly IUnitWork _unitWork;

        public AuthorizeApp(SystemAuthStrategy sysStrategy, NormalAuthStrategy normalAuthStrategy, IUnitWork unitWork)
        {
            _systemAuth = sysStrategy;
            _normalAuthStrategy = normalAuthStrategy;
            _unitWork = unitWork;
        }

        private NormalAuthStrategy Create(string loginuser)
        {
            if (loginuser == "System")
            {
                return _systemAuth;
            }

            _normalAuthStrategy.User = _unitWork.FindSingle<User>(u => u.Account == loginuser);
            return _normalAuthStrategy;
        }

        public AuthStrategyContext GetAuthStrategyContext(string username)
        {
            var service = Create(username);
            return new AuthStrategyContext(service);
        }
    }
}