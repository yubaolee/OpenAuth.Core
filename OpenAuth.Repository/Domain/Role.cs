using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Role")]
    public partial class Role :Entity
    {
        public Role()
        {
            this.Name = string.Empty;
            this.Status = 0;
            this.CreateTime = DateTime.Now;
            this.CreateId = string.Empty;
            this.TypeName = string.Empty;
            this.TypeId = string.Empty;
        }
        public string Name { get; set; }
        public int Status { get; set; }
        public DateTime CreateTime { get; set; }
        public string CreateId { get; set; }
        public string TypeName { get; set; }
        public string TypeId { get; set; }
    }
}
