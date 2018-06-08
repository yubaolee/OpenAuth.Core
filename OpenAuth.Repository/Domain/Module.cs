using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Module")]
    public partial class Module :TreeEntity
    {
        public Module()
        {
            this.Url = string.Empty;
            this.HotKey = string.Empty;
            this.IconName = string.Empty;
            this.Status = 0;
            this.Vector = string.Empty;
            this.SortNo = 0;
            this.Code = string.Empty;
        }

        public string Url { get; set; }
        public string HotKey { get; set; }
        public bool? IsLeaf { get; set; }
        public bool IsAutoExpand { get; set; }
        public string IconName { get; set; }
        public int Status { get; set; }
        public string Vector { get; set; }
        public int SortNo { get; set; }
        public string Code { get; set; }
    }
}
