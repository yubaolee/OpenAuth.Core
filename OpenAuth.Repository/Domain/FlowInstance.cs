using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    [Table("FlowInstance")]
    public partial class FlowInstance :Entity
    {
        public FlowInstance()
        {
            this.InstanceSchemeId = string.Empty;
            this.Code = string.Empty;
            this.CustomName = string.Empty;
            this.ActivityId = string.Empty;
            this.ActivityName = string.Empty;
            this.PreviousId = string.Empty;
            this.SchemeContent = string.Empty;
            this.SchemeId = string.Empty;
            this.DbName = string.Empty;
            this.FrmType = 0;
            this.FrmData = string.Empty;
            this.FrmContentData = string.Empty;
            this.FrmContentParse = string.Empty;
            this.FrmId = string.Empty;
            this.SchemeType = string.Empty;
            this.Disabled = 0;
            this.CreateDate = DateTime.Now;
            this.CreateUserId = string.Empty;
            this.CreateUserName = string.Empty;
            this.FlowLevel = 0;
            this.Description = string.Empty;
            this.IsFinish = 0;
            this.MakerList = string.Empty;
        }
        public string InstanceSchemeId { get; set; }
        public string Code { get; set; }
        public string CustomName { get; set; }
        public string ActivityId { get; set; }
        public int? ActivityType { get; set; }
        public string ActivityName { get; set; }
        public string PreviousId { get; set; }
        public string SchemeContent { get; set; }
        public string SchemeId { get; set; }
        public string DbName { get; set; }
        public string FrmData { get; set; }
        public int FrmType { get; set; }
        public string FrmContentData { get; set; }
        public string FrmContentParse { get; set; }
        public string FrmId { get; set; }
        public string SchemeType { get; set; }
        public int Disabled { get; set; }
        public DateTime CreateDate { get; set; }
        public string CreateUserId { get; set; }
        public string CreateUserName { get; set; }
        public int FlowLevel { get; set; }
        public string Description { get; set; }
        public int IsFinish { get; set; }
        public string MakerList { get; set; }
    }
}
