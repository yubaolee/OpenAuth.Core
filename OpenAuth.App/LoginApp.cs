using System;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    public class LoginApp
    {
        private IUserRepository _repository;

        public LoginApp(IUserRepository repository)
        {
            _repository = repository;
        }

        public void Login(string userName, string password)
        {
            var user = _repository.FindByAccount(userName);
            if (user == null)
            {
                throw new Exception("用户帐号不存在");
            }

            user.CheckLogin(password);

            LoginCacheApp.SetLogin(user);

        }
    }
}