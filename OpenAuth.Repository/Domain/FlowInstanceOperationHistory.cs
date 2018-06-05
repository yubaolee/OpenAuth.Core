using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace OpenAuth.Repository.Domain
{
    [Table("FlowInstanceOperationHistory")]
    public partial class FlowInstanceOperationHistory
    {
        public string Id { get; set; }
        public string InstanceId { get; set; }
        public string Content { get; set; }
        public DateTime CreateDate { get; set; }
        public string CreateUserId { get; set; }
        public string CreateUserName { get; set; }
    }
}
