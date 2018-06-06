using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Org")]
    public partial class Org :TreeEntity
    {
        public string HotKey { get; set; }
        public bool? IsLeaf { get; set; }
        public bool IsAutoExpand { get; set; }
        public string IconName { get; set; }
        public int Status { get; set; }
        public string BizCode { get; set; }
        public string CustomCode { get; set; }
        public DateTime CreateTime { get; set; }
        public int CreateId { get; set; }
        public int SortNo { get; set; }
        public string TypeName { get; set; }
        public string TypeId { get; set; }
    }
}
