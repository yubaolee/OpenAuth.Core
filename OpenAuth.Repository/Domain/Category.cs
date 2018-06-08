using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Category")]
    public partial class Category :Entity
    {
        public Category()
        {
            this.Name = string.Empty;
            this.SortNo = 0;
            this.Icon = string.Empty;
            this.Description = string.Empty;
            this.TypeId = string.Empty;
        }

        public string Name { get; set; }
        public bool Disabled { get; set; }
        public int SortNo { get; set; }
        public string Icon { get; set; }
        public string Description { get; set; }
        public string TypeId { get; set; }
    }
}
