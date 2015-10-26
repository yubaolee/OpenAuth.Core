using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class PageElement
    {
        public int Id { get; set; }
        public string DomId { get; set; }
        public string Name { get; set; }
        public int Type { get; set; }
        public int ModuleId { get; set; }
        public string Remark { get; set; }
    }
}
