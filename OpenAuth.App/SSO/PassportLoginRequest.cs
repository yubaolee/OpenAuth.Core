using System;

namespace OpenAuth.App.SSO
{

    public class PassportLoginRequest
    {
        public string UserName { get; set; }

        public string Password { get; set; }

        public string AppKey { get; set; }

        public void Trim()
        {
            if (string.IsNullOrEmpty(UserName))
            {
                throw new Exception("用户名不能为空");
            }

            if (string.IsNullOrEmpty(Password))
            {
                throw new Exception("密码不能为空");
            }
            UserName = UserName.Trim();
            Password = Password.Trim();
            if(!string.IsNullOrEmpty(AppKey)) AppKey = AppKey.Trim();
        }
    }
}