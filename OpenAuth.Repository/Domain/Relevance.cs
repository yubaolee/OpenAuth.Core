using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Relevance")]
    public partial class Relevance :Entity
    {
        public string Description { get; set; }
        public string Key { get; set; }
        public int Status { get; set; }
        public DateTime OperateTime { get; set; }
        public string OperatorId { get; set; }
        public string FirstId { get; set; }
        public string SecondId { get; set; }
    }
}
