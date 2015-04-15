using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class User
    {
        public User()
        {
            this.Departments = new List<Department>();
            this.Roles = new List<Role>();
        }

        public string UserId { get; set; }
        public string Account { get; set; }
        public string Password { get; set; }
        public string RealName { get; set; }
        public string RoleId { get; set; }
        public Nullable<int> Enabled { get; set; }
        public Nullable<int> DeleteMark { get; set; }
        public virtual ICollection<Department> Departments { get; set; }
        public virtual ICollection<Role> Roles { get; set; }
    }
}
