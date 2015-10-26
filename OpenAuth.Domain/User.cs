using System;
using System.Collections.Generic;

namespace OpenAuth.Domain
{
    public partial class User
    {
        public int Id { get; set; }
        public string Account { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }
        public int Sex { get; set; }
        public int Status { get; set; }
        public int Type { get; set; }
        public string BizCode { get; set; }
        public System.DateTime CreateTime { get; set; }
        public int CreateId { get; set; }
    }
}
