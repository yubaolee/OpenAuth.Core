using System;
using System.Collections.Generic;

namespace OpenAuth.Domain.Model
{
    public partial class Menu
    {
        public Menu()
        {
            this.Buttons = new List<Button>();
            this.RoleMenuButtons = new List<RoleMenuButton>();
        }

        public string MenuId { get; set; }
        public string ParentId { get; set; }
        public string FullName { get; set; }
        public string Description { get; set; }
        public string Img { get; set; }
        public Nullable<int> Category { get; set; }
        public string NavigateUrl { get; set; }
        public string FormName { get; set; }
        public string Target { get; set; }
        public Nullable<int> IsUnfold { get; set; }
        public Nullable<int> Enabled { get; set; }
        public Nullable<int> SortCode { get; set; }
        public virtual ICollection<Button> Buttons { get; set; }
        public virtual ICollection<RoleMenuButton> RoleMenuButtons { get; set; }
    }
}
