using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class UserRole
    {
        public int Id { get; set; }
        public int RoleId { get; set; }
        public int UserId { get; set; }
        public System.DateTime OperateTime { get; set; }
        public int OperatorId { get; set; }
    }
}
