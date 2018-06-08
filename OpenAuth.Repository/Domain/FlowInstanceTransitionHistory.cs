using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("FlowInstanceTransitionHistory")]
    public partial class FlowInstanceTransitionHistory :Entity
    {
        public FlowInstanceTransitionHistory()
        {
            this.InstanceId = string.Empty;
            this.FromNodeId = string.Empty;
            this.FromNodeName = string.Empty;
            this.ToNodeId = string.Empty;
            this.ToNodeName = string.Empty;
            this.TransitionSate = 0;
            this.IsFinish = 0;
            this.CreateDate = DateTime.Now;
            this.CreateUserId = string.Empty;
            this.CreateUserName = string.Empty;
        }

        public string InstanceId { get; set; }
        public string FromNodeId { get; set; }
        public int? FromNodeType { get; set; }
        public string FromNodeName { get; set; }
        public string ToNodeId { get; set; }
        public int? ToNodeType { get; set; }
        public string ToNodeName { get; set; }
        public int TransitionSate { get; set; }
        public int IsFinish { get; set; }
        public DateTime CreateDate { get; set; }
        public string CreateUserId { get; set; }
        public string CreateUserName { get; set; }
    }
}
