using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Application")]
    public partial class Application :Entity
    {
        public Application()
        {
            this.Name = string.Empty;
            this.AppSecret = string.Empty;
            this.Description = string.Empty;
            this.Icon = string.Empty;
            this.CreateTime = DateTime.Now;
            this.CreateUser = string.Empty;
        }
        public string Name { get; set; }
        public string AppSecret { get; set; }
        public string Description { get; set; }
        public string Icon { get; set; }
        public bool Disable { get; set; }
        public DateTime CreateTime { get; set; }
        public string CreateUser { get; set; }
    }
}
