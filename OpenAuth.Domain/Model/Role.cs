using System;
using System.Collections.Generic;

namespace OpenAuth.Domain.Model
{
    public partial class Role
    {
        public Role()
        {
            this.DataPermissions = new List<DataPermission>();
            this.RoleMenus = new List<Menu>();
            this.RoleMenuButtons = new List<RoleMenuButton>();
            this.Users = new List<User>();
        }

        public string RoleId { get; set; }
        public string ParentId { get; set; }
        public string FullName { get; set; }
        public string Category { get; set; }
        public string Description { get; set; }
        public Nullable<int> Enabled { get; set; }
        public Nullable<int> SortCode { get; set; }
        public Nullable<int> DeleteMark { get; set; }
        public string DepartmentId { get; set; }
        public virtual ICollection<DataPermission> DataPermissions { get; set; }
        public virtual Department Department { get; set; }
        public virtual ICollection<Menu> RoleMenus { get; set; }
        public virtual ICollection<RoleMenuButton> RoleMenuButtons { get; set; }
        public virtual ICollection<User> Users { get; set; }
    }
}
