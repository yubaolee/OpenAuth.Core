using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Stock")]
    public partial class Stock :Entity
    {
        public Stock()
        {
            this.Name = string.Empty;
            this.Number = 0;
            this.Price = 0;
            this.Status = 0;
            this.Viewable = string.Empty;
            this.User = string.Empty;
            this.Time = DateTime.Now;
            this.OrgId = string.Empty;
        }
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
