using OpenAuth.Domain.Interface;

namespace OpenAuth.Domain.Service
{
    /// <summary>
    ///  权限分配工厂，根据是否是开发者账号创建
    /// </summary>
    public class AuthoriseFactory
    {
        private IUnitWork _unitWork;

        public AuthoriseFactory(IUnitWork unitWork)
        {
            _unitWork = unitWork;
        }
        public AuthoriseService Create(string loginuser)
        {
            if (loginuser == "System")
            {
                return new SystemAuthService(_unitWork);
            }
            else
            {
                return  new AuthoriseService(_unitWork)
                {
                    User = _unitWork.FindSingle<User>(u =>u.Account == loginuser)
                };
            }
        }
    }
}