using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Stock")]
    public partial class Stock :Entity
    {
        public string Name { get; set; }
        public int Number { get; set; }
        public decimal Price { get; set; }
        public int Status { get; set; }
        public string Viewable { get; set; }
        public string User { get; set; }
        public DateTime Time { get; set; }
        public string OrgId { get; set; }
    }
}
