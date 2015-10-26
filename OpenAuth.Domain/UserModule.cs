using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class UserModule
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int ModuleId { get; set; }
        public int Type { get; set; }
        public System.DateTime OperateTime { get; set; }
        public int OperatorId { get; set; }
    }
}
