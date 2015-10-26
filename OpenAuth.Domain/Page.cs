using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class Page
    {
        public int Id { get; set; }
        public int ModuleId { get; set; }
        public string Name { get; set; }
        public string Url { get; set; }
        public int Type { get; set; }
        public bool Enabled { get; set; }
        public bool IsDefault { get; set; }
        public string Icon { get; set; }
        public string IconBig { get; set; }
        public string Vector { get; set; }
        public int SortNo { get; set; }
    }
}
