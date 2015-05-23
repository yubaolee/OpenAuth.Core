using System;
using System.Collections.Generic;
using OpenAuth.Domain.Utility;

namespace OpenAuth.Domain.Model
{
    public partial class Button : EntityBase<string>, IAggregateRoot
    {
        public Button()
        {
            this.Menus = new List<Menu>();
        }

        public string FullName { get; set; }
        public string Img { get; set; }
        public string Event { get; set; }
        public string Control_ID { get; set; }
        public string Category { get; set; }
        public string Description { get; set; }
        public bool Enabled { get; set; }
        public Nullable<int> SortCode { get; set; }
        public virtual ICollection<Menu> Menus { get; set; }
        protected override void Validate()
        {
            throw new NotImplementedException();
        }
    }
}
