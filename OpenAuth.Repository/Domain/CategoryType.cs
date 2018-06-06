using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("CategoryType")]
    public partial class CategoryType :Entity
    {
        public string Name { get; set; }
        public DateTime CreateTime { get; set; }
    }
}
