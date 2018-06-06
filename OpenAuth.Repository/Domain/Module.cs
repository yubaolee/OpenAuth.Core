using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Module")]
    public partial class Module :TreeEntity
    {

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
