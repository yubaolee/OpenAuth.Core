using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("CategoryType")]
    public partial class CategoryType :Entity
    {
        public CategoryType()
        {
            this.Name = string.Empty;
            this.CreateTime = DateTime.Now;
        }

        public string Name { get; set; }
        public DateTime CreateTime { get; set; }
    }
}
