using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace OpenAuth.Repository.Domain
{
    [Table("Org")]
    public partial class Org
    {
        public string Id { get; set; }
        public string CascadeId { get; set; }
        public string Name { get; set; }
        public string HotKey { get; set; }
        public string ParentName { get; set; }
        public bool? IsLeaf { get; set; }
        public bool IsAutoExpand { get; set; }
        public string IconName { get; set; }
        public int Status { get; set; }
        public string BizCode { get; set; }
        public string CustomCode { get; set; }
        public DateTime CreateTime { get; set; }
        public int CreateId { get; set; }
        public int SortNo { get; set; }
        public string ParentId { get; set; }
        public string TypeName { get; set; }
        public string TypeId { get; set; }
    }
}
