using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class Org
    {
        public int Id { get; set; }
        public string CascadeId { get; set; }
        public string Name { get; set; }
        public string HotKey { get; set; }
        public int ParentId { get; set; }
        public string ParentName { get; set; }
        public bool IsLeaf { get; set; }
        public bool IsAutoExpand { get; set; }
        public string IconName { get; set; }
        public int Status { get; set; }
        public int Type { get; set; }
        public string BizCode { get; set; }
        public string CustomCode { get; set; }
        public System.DateTime CreateTime { get; set; }
        public int CreateId { get; set; }
        public int SortNo { get; set; }

        public Org()
        {
            HotKey = "";
            IconName = "";
            BizCode = "";
            CustomCode = "";
        }
    }
}
