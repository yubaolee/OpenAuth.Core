using System.Linq;
using System.Security.Cryptography;
using OpenAuth.App.DTO;
using OpenAuth.Domain.Interface;
using OpenAuth.Domain.Service;

namespace OpenAuth.App
{
    public class LoginApp
    {
        private LoginService _loginService;

        public LoginApp(IUserRepository repository)
        {
            _loginService = new LoginService(repository);
        }

        public LoginResponse Login(LoginRequest request)
        {
            var resp = new LoginResponse {UserName = request.UserName};

            var user = _loginService.Login(request.UserName, request.Password);
             if (user == null)
            {
                resp.Message = "用户名不存在";
            }
            else if (!user.Password.Equals(request.Password))
            {
                resp.Message = "密码错误";
            }
            else if (!user.Enabled)
            {
                resp.Message = "该用户被禁用";
            }
            else
            {
                resp.UserId = user.UserId;
                resp.Success = true;
                foreach (var role in user.Roles)
                {
                    resp.UserRoleNames.Add(role.FullName);
                }
            }
            return resp;
        }
    }
}