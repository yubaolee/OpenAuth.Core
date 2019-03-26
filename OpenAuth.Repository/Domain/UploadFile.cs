// <copyright file="UploadFile.cs" company="openauth.me">
// Copyright (c) 2019 openauth.me. All rights reserved.
// </copyright>
// <author>www.cnblogs.com/yubaolee</author>
// <date>2019-03-07</date>
// <summary>附加实体</summary>

using System;
using System.ComponentModel.DataAnnotations.Schema;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    /// <summary>
	/// 文件
	/// </summary>
    [Table("UploadFile")]
    public partial class UploadFile : Entity
    {
        public UploadFile()
        {
          this.FileName= string.Empty;
          this.FilePath= string.Empty;
          this.Description= string.Empty;
          this.FileType= string.Empty;
          this.Extension= string.Empty;
          this.SortCode= 0;
          this.CreateUserName= string.Empty;
          this.CreateTime= DateTime.Now;
          this.Thumbnail= string.Empty;
          this.BelongApp= string.Empty;
          this.BelongAppId= string.Empty;
        }

        /// <summary>
	    /// 文件名称
	    /// </summary>
        public string FileName { get; set; }
        /// <summary>
	    /// 文件路径
	    /// </summary>
        public string FilePath { get; set; }
        /// <summary>
	    /// 描述
	    /// </summary>
        public string Description { get; set; }
        /// <summary>
	    /// 文件类型
	    /// </summary>
        public string FileType { get; set; }
        /// <summary>
	    /// 文件大小
	    /// </summary>
        public long FileSize { get; set; }
        /// <summary>
	    /// 扩展名称
	    /// </summary>
        public string Extension { get; set; }
        /// <summary>
	    /// 是否可用
	    /// </summary>
        public bool Enable { get; set; }
        /// <summary>
	    /// 排序
	    /// </summary>
        public int SortCode { get; set; }
        /// <summary>
	    /// 删除标识
	    /// </summary>
        public bool DeleteMark { get; set; }
        /// <summary>
	    /// 上传人
	    /// </summary>
        public System.Guid? CreateUserId { get; set; }
        /// <summary>
	    /// 上传人姓名
	    /// </summary>
        public string CreateUserName { get; set; }
        /// <summary>
	    /// 上传时间
	    /// </summary>
        public System.DateTime CreateTime { get; set; }
        /// <summary>
	    /// 缩略图
	    /// </summary>
        public string Thumbnail { get; set; }
        /// <summary>
	    /// 所属应用
	    /// </summary>
        public string BelongApp { get; set; }
        /// <summary>
	    /// 所属应用ID
	    /// </summary>
        public string BelongAppId { get; set; }

    }
}