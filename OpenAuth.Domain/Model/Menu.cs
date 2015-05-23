using System;
using System.Collections.Generic;
using OpenAuth.Domain.Utility;

namespace OpenAuth.Domain.Model
{
    public partial class Menu :EntityBase<string>, IAggregateRoot
    {
        public Menu()
        {
            this.Buttons = new List<Button>();
            this.Roles = new List<Role>();
        }

        protected override void Validate()
        {
            throw new NotImplementedException();
        }

        public string ParentId { get; set; }
        public string FullName { get; set; }
        public string Description { get; set; }
        public string Img { get; set; }
        public Nullable<int> Category { get; set; }
        public string NavigateUrl { get; set; }
        public string FormName { get; set; }
        public string Target { get; set; }
        public bool IsUnfold { get; set; }
        public bool Enabled { get; set; }
        public Nullable<int> SortCode { get; set; }
        public virtual ICollection<Button> Buttons { get; set; }
        public virtual ICollection<Role> Roles { get; set; } 
    }
}
