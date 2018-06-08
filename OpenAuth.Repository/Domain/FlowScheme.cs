using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("FlowScheme")]
    public partial class FlowScheme : Entity
    {
        public FlowScheme()
        {
            this.SchemeCode = string.Empty;
            this.SchemeName = string.Empty;
            this.SchemeType = string.Empty;
            this.SchemeVersion = string.Empty;
            this.SchemeCanUser = string.Empty;
            this.SchemeContent = string.Empty;
            this.FrmId = string.Empty;
            this.FrmType = 0;
            this.AuthorizeType = 0;
            this.SortCode = 0;
            this.DeleteMark = 0;
            this.Disabled = 0;
            this.Description = string.Empty;
            this.CreateDate = DateTime.Now;
            this.CreateUserId = string.Empty;
            this.CreateUserName = string.Empty;
            this.ModifyDate = DateTime.Now;
            this.ModifyUserId = string.Empty;
            this.ModifyUserName = string.Empty;
        }
        public string SchemeCode { get; set; }
        public string SchemeName { get; set; }
        public string SchemeType { get; set; }
        public string SchemeVersion { get; set; }
        public string SchemeCanUser { get; set; }
        public string SchemeContent { get; set; }
        public string FrmId { get; set; }
        public int FrmType { get; set; }
        public int AuthorizeType { get; set; }
        public int SortCode { get; set; }
        public int DeleteMark { get; set; }
        public int Disabled { get; set; }
        public string Description { get; set; }
        public DateTime CreateDate { get; set; }
        public string CreateUserId { get; set; }
        public string CreateUserName { get; set; }
        public DateTime? ModifyDate { get; set; }
        public string ModifyUserId { get; set; }
        public string ModifyUserName { get; set; }
    }
}
