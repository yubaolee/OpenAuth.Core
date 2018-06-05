using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace OpenAuth.Repository.Domain
{
    [Table("Role")]
    public partial class Role
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public int Status { get; set; }
        public DateTime CreateTime { get; set; }
        public string CreateId { get; set; }
        public string TypeName { get; set; }
        public string TypeId { get; set; }
    }
}
