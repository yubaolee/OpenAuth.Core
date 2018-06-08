using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Resource")]
    public partial class Resource :TreeEntity
    {
        public Resource()
        {
            this.CascadeId = string.Empty;
            this.Name = string.Empty;
            this.SortNo = 0;
            this.Description = string.Empty;
            this.ParentName = string.Empty;
            this.ParentId = string.Empty;
            this.AppId = string.Empty;
            this.AppName = string.Empty;
            this.TypeName = string.Empty;
            this.TypeId = string.Empty;
        }

        public int SortNo { get; set; }
        public string Description { get; set; }
        public string AppId { get; set; }
        public string AppName { get; set; }
        public string TypeName { get; set; }
        public string TypeId { get; set; }
        public bool Disable { get; set; }
    }
}
