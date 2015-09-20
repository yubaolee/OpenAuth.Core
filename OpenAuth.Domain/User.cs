using System;

namespace OpenAuth.Domain
{
    public partial class User
    {
        public string UserId { get; set; }
        public string Account { get; set; }
        public string Password { get; set; }
        public string RealName { get; set; }
        public string RoleId { get; set; }
        public bool Enabled { get; set; }
        public bool DeleteMark { get; set; }

        public void CheckLogin(string password)
        {
            if(this.Password != password)
                throw new Exception("密码错误");
            if(!this.Enabled)
                throw new Exception("用户已经被停用");
            if (DeleteMark)
                throw new Exception("该账号已经被删除");
        }
    }
}
