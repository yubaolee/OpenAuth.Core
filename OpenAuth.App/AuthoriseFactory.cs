using OpenAuth.Domain.Interface;

namespace OpenAuth.Domain.Service
{
    /// <summary>
    ///  权限分配工厂，根据是否是开发者账号创建
    /// </summary>
    public class AuthoriseFactory
    {
          public IUnitWork _unitWork { get; set; }

        public AuthoriseService Create(string loginuser)
        {
            if (loginuser == "System")
            {
                return new SystemAuthService();
            }
            else
            {
                return  new AuthoriseService()
                {
                    _unitWork = _unitWork,
                    User = _unitWork.FindSingle<User>(u =>u.Account == loginuser)
                };
            }
        }
    }
}