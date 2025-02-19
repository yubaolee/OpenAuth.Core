﻿using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    /// <summary>
	/// 资源表
	/// </summary>
    [Table("SysResource")]
    public partial class SysResource : TreeEntity
    {
        public SysResource()
        {
          this.Name= string.Empty;
          this.SortNo= 0;
          this.Description= string.Empty;
          this.AppId= string.Empty;
          this.AppName= string.Empty;
          this.TypeName= string.Empty;
          this.TypeId= string.Empty;
          this.CreateTime= DateTime.Now;
          this.CreateUserId= string.Empty;
          this.CreateUserName= string.Empty;
          this.UpdateTime= DateTime.Now;
          this.UpdateUserId= string.Empty;
          this.UpdateUserName= string.Empty;
        }
        

        /// <summary>
        /// 排序号
        /// </summary>
        [Description("排序号")]
        public int SortNo { get; set; }
        /// <summary>
        /// 描述
        /// </summary>
        [Description("描述")]
        public string Description { get; set; }
        /// <summary>
        /// 资源所属应用ID
        /// </summary>
        [Description("资源所属应用ID")]
        [Browsable(false)]
        public string AppId { get; set; }
        /// <summary>
        /// 所属应用名称
        /// </summary>
        [Description("所属应用名称")]
        public string AppName { get; set; }
        /// <summary>
        /// 分类名称
        /// </summary>
        [Description("分类名称")]
        public string TypeName { get; set; }
        /// <summary>
        /// 分类ID
        /// </summary>
        [Description("分类ID")]
        [Browsable(false)]
        public string TypeId { get; set; }
        /// <summary>
        /// 是否可用
        /// </summary>
        [Description("是否可用")]
        public bool Disable { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        [Description("创建时间")]
        public System.DateTime CreateTime { get; set; }
        /// <summary>
        /// 创建人ID
        /// </summary>
        [Description("创建人ID")]
        [Browsable(false)]
        public string CreateUserId { get; set; }
        /// <summary>
        /// 创建人
        /// </summary>
        [Description("创建人")]
        public string CreateUserName { get; set; }
        /// <summary>
        /// 最后更新时间
        /// </summary>
        [Description("最后更新时间")]
        public System.DateTime? UpdateTime { get; set; }
        /// <summary>
        /// 最后更新人ID
        /// </summary>
        [Description("最后更新人ID")]
        [Browsable(false)]
        public string UpdateUserId { get; set; }
        /// <summary>
        /// 最后更新人
        /// </summary>
        [Description("最后更新人")]
        public string UpdateUserName { get; set; }
    }
}