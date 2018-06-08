using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("FlowInstanceOperationHistory")]
    public partial class FlowInstanceOperationHistory :Entity
    {
        public FlowInstanceOperationHistory()
        {
            this.InstanceId = string.Empty;
            this.Content = string.Empty;
            this.CreateDate = DateTime.Now;
            this.CreateUserId = string.Empty;
            this.CreateUserName = string.Empty;
        }
        public string InstanceId { get; set; }
        public string Content { get; set; }
        public DateTime CreateDate { get; set; }
        public string CreateUserId { get; set; }
        public string CreateUserName { get; set; }
    }
}
