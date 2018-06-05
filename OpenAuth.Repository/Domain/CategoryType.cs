using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace OpenAuth.Repository.Domain
{
    [Table("CategoryType")]
    public partial class CategoryType
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public DateTime CreateTime { get; set; }
    }
}
