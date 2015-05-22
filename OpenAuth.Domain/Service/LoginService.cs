using System;
using OpenAuth.Domain.Interface;
using OpenAuth.Domain.Model;
namespace OpenAuth.Domain.Service
{
    public class LoginService
    {
        private IUserRepository _userRepository;
        public LoginService(IUserRepository repository)
        {
            _userRepository = repository;
        }
        public User Login(string username, string password)
        {
            var user = _userRepository.FindByAccount(username);
            if (user == null)
            {
                throw new Exception("用户名不存在");
            }
            if (!user.Password.Equals(password))
            {
                throw new Exception("密码错误");
            }
            if (!user.Enabled)
            {
                throw new Exception("该用户被禁用");
            }
            return user;
        }
    }
}
