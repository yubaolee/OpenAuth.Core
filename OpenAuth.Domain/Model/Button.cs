using System;
using System.Collections.Generic;

namespace OpenAuth.Domain.Model
{
    public partial class Button
    {
        public Button()
        {
            this.RoleMenuButtons = new List<RoleMenuButton>();
        }

        public string ButtonId { get; set; }
        public string FullName { get; set; }
        public string Img { get; set; }
        public string Event { get; set; }
        public string Control_ID { get; set; }
        public string Category { get; set; }
        public string Description { get; set; }
        public Nullable<int> Enabled { get; set; }
        public Nullable<int> SortCode { get; set; }
        public virtual ICollection<RoleMenuButton> RoleMenuButtons { get; set; }
    }
}
