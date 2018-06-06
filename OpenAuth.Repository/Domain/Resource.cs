using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Resource")]
    public partial class Resource :TreeEntity
    {

        public int SortNo { get; set; }
        public string Description { get; set; }
        public string AppId { get; set; }
        public string AppName { get; set; }
        public string TypeName { get; set; }
        public string TypeId { get; set; }
        public bool Disable { get; set; }
    }
}
