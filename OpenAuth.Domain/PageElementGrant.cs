using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class PageElementGrant
    {
        public int Id { get; set; }
        public int ElementId { get; set; }
        public int UserId { get; set; }
        public int RoleId { get; set; }
        public int PostId { get; set; }
        public int GrantType { get; set; }
    }
}
