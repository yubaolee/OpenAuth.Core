using System;

namespace OpenAuth.App.SSO
{

    public class PassportLoginRequest
    {
        /// <example>System</example>
        public string Account { get; set; }

        /// <example>123456</example>
        public string Password { get; set; }

        /// <summary>
        /// 应用的AppSecrect，目前没判定可以随便填一个。如果需要判定请根据注释调整LoginParse.Do方法
        /// </summary>
        /// <example>openauth</example>
        public string AppKey { get; set; }

        public void Trim()
        {
            if (string.IsNullOrEmpty(Account))
            {
                throw new Exception("用户名不能为空");
            }

            if (string.IsNullOrEmpty(Password))
            {
                throw new Exception("密码不能为空");
            }
            Account = Account.Trim();
            Password = Password.Trim();
            if(!string.IsNullOrEmpty(AppKey)) AppKey = AppKey.Trim();
        }
    }
}