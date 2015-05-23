using System;
using System.Collections.Generic;
using OpenAuth.Domain.Utility;

namespace OpenAuth.Domain.Model
{
    public partial class Role :EntityBase<string>, IAggregateRoot
    {
        public Role()
        {
            this.DataPermissions = new List<DataPermission>();
            this.RoleMenus = new List<Menu>();
            this.Users = new List<User>();
        }

        protected override void Validate()
        {
            throw new NotImplementedException();
        }

        public string ParentId { get; set; }
        public string FullName { get; set; }
        public string Category { get; set; }
        public string Description { get; set; }
        public bool Enabled { get; set; }
        public Nullable<int> SortCode { get; set; }
        public bool DeleteMark { get; set; }
        public string DepartmentId { get; set; }
        public virtual ICollection<DataPermission> DataPermissions { get; set; }
        public virtual Department Department { get; set; }
        public virtual ICollection<Menu> RoleMenus { get; set; }
        public virtual ICollection<User> Users { get; set; }
    }
}
