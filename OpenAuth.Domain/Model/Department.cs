using System;
using System.Collections.Generic;

namespace OpenAuth.Domain.Model
{
    public partial class Department
    {
        public Department()
        {
            this.Roles = new List<Role>();
            this.Users = new List<User>();
        }

        public string DepartmentId { get; set; }
        public string ParentId { get; set; }
        public string FullName { get; set; }
        public string Description { get; set; }
        public bool Enabled { get; set; }
        public Nullable<int> SortCode { get; set; }
        public bool DeleteMark { get; set; }
        public virtual ICollection<Role> Roles { get; set; }
        public virtual ICollection<User> Users { get; set; }
    }
}
