using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class ModuleRole
    {
        public int Id { get; set; }
        public int RoleId { get; set; }
        public int ModuleId { get; set; }
        public int Type { get; set; }
        public System.DateTime OperateTime { get; set; }
        public int OperatorId { get; set; }
    }
}
