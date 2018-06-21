using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Org")]
    public partial class Org :TreeEntity
    {
        public Org()
        {
            this.CascadeId = string.Empty;
            this.Name = string.Empty;
            this.HotKey = string.Empty;
            this.ParentName = string.Empty;
            this.IconName = string.Empty;
            this.Status = 0;
            this.BizCode = string.Empty;
            this.CustomCode = string.Empty;
            this.CreateTime = DateTime.Now;
            this.CreateId = 0;
            this.SortNo = 0;
            this.ParentId = string.Empty;
            this.TypeName = string.Empty;
            this.TypeId = string.Empty;
            this.IsLeaf = false;
        }

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
