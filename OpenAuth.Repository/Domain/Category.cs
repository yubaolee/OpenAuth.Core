using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Category")]
    public partial class Category :Entity
    {
        public string Name { get; set; }
        public bool Disabled { get; set; }
        public int SortNo { get; set; }
        public string Icon { get; set; }
        public string Description { get; set; }
        public string TypeId { get; set; }
    }
}
