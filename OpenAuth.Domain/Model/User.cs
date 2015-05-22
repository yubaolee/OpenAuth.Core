using System;
using System.Collections.Generic;
using OpenAuth.Domain.Utility;

namespace OpenAuth.Domain.Model
{
    public partial class User :EntityBase<string>
    {
        public User()
        {
            this.Departments = new List<Department>();
            this.Roles = new List<Role>();
        }

        public string Account { get; set; }
        public string Password { get; set; }
        public string RealName { get; set; }
        public string RoleId { get; set; }
        public bool Enabled { get; set; }
        public bool DeleteMark { get; set; }
        public virtual ICollection<Department> Departments { get; set; }
        public virtual ICollection<Role> Roles { get; set; }

        public Role DefaultRole { get; set; }

        protected override void Validate()
        {
            if(string.IsNullOrEmpty(Account))
                AddBrokenRule(new BusinessRule("Account","用户帐号不能为空"));
        }
    }
}
