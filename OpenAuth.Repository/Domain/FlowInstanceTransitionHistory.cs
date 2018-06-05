using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace OpenAuth.Repository.Domain
{
    [Table("FlowInstanceTransitionHistory")]
    public partial class FlowInstanceTransitionHistory
    {
        public string Id { get; set; }
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
