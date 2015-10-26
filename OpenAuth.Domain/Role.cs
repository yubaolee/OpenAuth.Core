using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class Role
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Status { get; set; }
        public int Type { get; set; }
        public System.DateTime CreateTime { get; set; }
        public string CreateId { get; set; }
        public int CreateOrgId { get; set; }
        public string CreateOrgCascadeId { get; set; }
    }
}
