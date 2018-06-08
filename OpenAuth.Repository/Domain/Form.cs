using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("Form")]
    public partial class Form : Entity
    {
        public Form()
        {
            this.Name = string.Empty;
            this.Fields = 0;
            this.ContentData = string.Empty;
            this.ContentParse = string.Empty;
            this.Content = string.Empty;
            this.SortCode = 0;
            this.Delete = 0;
            this.DbName = string.Empty;
            this.Enabled = 0;
            this.Description = string.Empty;
            this.CreateDate = DateTime.Now;
            this.CreateUserId = string.Empty;
            this.CreateUserName = string.Empty;
            this.ModifyDate = DateTime.Now;
            this.ModifyUserId = string.Empty;
            this.ModifyUserName = string.Empty;
        }
        public string Name { get; set; }
        public int Fields { get; set; }
        public string ContentData { get; set; }
        public string ContentParse { get; set; }
        public string Content { get; set; }
        public int SortCode { get; set; }
        public int Delete { get; set; }
        public string DbName { get; set; }
        public int Enabled { get; set; }
        public string Description { get; set; }
        public DateTime CreateDate { get; set; }
        public string CreateUserId { get; set; }
        public string CreateUserName { get; set; }
        public DateTime? ModifyDate { get; set; }
        public string ModifyUserId { get; set; }
        public string ModifyUserName { get; set; }
    }
}
