using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class UserOrg
    {
        public int Id { get; set; }
        public int OrgId { get; set; }
        public int UserId { get; set; }
        public System.DateTime OperateTime { get; set; }
        public int OperatorId { get; set; }
    }
}
