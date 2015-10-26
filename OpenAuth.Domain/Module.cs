using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class Module
    {
        public int Id { get; set; }
        public string CascadeId { get; set; }
        public string Name { get; set; }
        public string Url { get; set; }
        public string HotKey { get; set; }
        public int ParentId { get; set; }
        public bool IsLeaf { get; set; }
        public bool IsAutoExpand { get; set; }
        public string IconName { get; set; }
        public int Status { get; set; }
        public string ParentName { get; set; }
        public string Vector { get; set; }
        public int SortNo { get; set; }
    }
}
