using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("User")]
    public partial class User : Entity
    {
        public User()
        {
            this.Account = string.Empty;
            this.Password = string.Empty;
            this.Name = string.Empty;
            this.Sex = 0;
            this.Status = 0;
            this.BizCode = string.Empty;
            this.CreateTime = DateTime.Now;
            this.CrateId = string.Empty;
            this.TypeName = string.Empty;
            this.TypeId = string.Empty;
        }
        public string Account { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }
        public int Sex { get; set; }
        public int Status { get; set; }
        public string BizCode { get; set; }
        public DateTime CreateTime { get; set; }
        public string CrateId { get; set; }
        public string TypeName { get; set; }
        public string TypeId { get; set; }
    }
}
