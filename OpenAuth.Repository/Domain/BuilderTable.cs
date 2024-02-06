﻿//------------------------------------------------------------------------------
// <autogenerated>
//     This code was generated by a CodeSmith Template.
//
//     DO NOT MODIFY contents of this file. Changes to this
//     file will be lost if the code is regenerated.
//     Author:Yubao Li
// </autogenerated>
//------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;
using OpenAuth.Repository.Core;

namespace OpenAuth.Repository.Domain
{
    /// <summary>
	/// 代码生成器的表信息
	/// </summary>
    [Table("BuilderTable")]
    public partial class BuilderTable : StringEntity
    {
        public BuilderTable()
        {
          this.TableName= string.Empty;
          this.Comment= string.Empty;
          this.DetailTableName= string.Empty;
          this.DetailComment= string.Empty;
          this.ClassName= string.Empty;
          this.Namespace= string.Empty;
          this.ModuleCode= string.Empty;
          this.ModuleName= string.Empty;
          this.Folder= string.Empty;
          this.Options= string.Empty;
          this.TypeId= string.Empty;
          this.TypeName= string.Empty;
          this.CreateTime= DateTime.Now;
          this.CreateUserId= string.Empty;
          this.UpdateTime= DateTime.Now;
          this.UpdateUserId= string.Empty;
          this.UpdateUserName= string.Empty;
          this.CreateUserName= string.Empty;
        }

        
        /// <summary>
        /// 表英文全称
        /// </summary>
        [Description("表英文全称")]
        public string TableName { get; set; }
        /// <summary>
        /// 表描述、中文名称
        /// </summary>
        [Description("表描述、中文名称")]
        public string Comment { get; set; }
        /// <summary>
        /// 子表英文全称
        /// </summary>
        [Description("子表英文全称")]
        public string DetailTableName { get; set; }
        /// <summary>
        /// 子表描述、中文名称
        /// </summary>
        [Description("子表描述、中文名称")]
        public string DetailComment { get; set; }
        /// <summary>
        /// 实体类名称
        /// </summary>
        [Description("实体类名称")]
        public string ClassName { get; set; }
        /// <summary>
        /// 命名空间
        /// </summary>
        [Description("命名空间")]
        public string Namespace { get; set; }
        /// <summary>
        /// 模块标识
        /// </summary>
        [Description("模块标识")]
        public string ModuleCode { get; set; }
        /// <summary>
        /// 模块名称
        /// </summary>
        [Description("模块名称")]
        public string ModuleName { get; set; }
        /// <summary>
        /// 代码相对文件夹路径
        /// </summary>
        [Description("代码相对文件夹路径")]
        public string Folder { get; set; }
        /// <summary>
        /// 其它生成选项
        /// </summary>
        [Description("其它生成选项")]
        public string Options { get; set; }
        /// <summary>
        /// 分类ID
        /// </summary>
        [Description("分类ID")]
        [Browsable(false)]
        public string TypeId { get; set; }
        /// <summary>
        /// 分类名称
        /// </summary>
        [Description("分类名称")]
        public string TypeName { get; set; }
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
        /// 修改时间
        /// </summary>
        [Description("修改时间")]
        public System.DateTime? UpdateTime { get; set; }
        /// <summary>
        /// 修改人ID
        /// </summary>
        [Description("修改人ID")]
        [Browsable(false)]
        public string UpdateUserId { get; set; }
        /// <summary>
        /// 修改人姓名
        /// </summary>
        [Description("修改人姓名")]
        public string UpdateUserName { get; set; }
        /// <summary>
        /// 创建人姓名
        /// </summary>
        [Description("创建人姓名")]
        public string CreateUserName { get; set; }
        
        /// <summary>
        /// 是否动态加载表头信息
        /// </summary>
        [Description("是否动态加载表头信息")]
        public bool IsDynamicHeader { get; set; }
        
        
        /// <summary>
        /// 字表外键
        /// </summary>
        [Description("字表外键")]
        public string ForeignKey { get; set; }
        
        /// <summary>
        /// 主表ID，如果为空表示为主表
        /// </summary>
        [Description("主表ID，如果为空表示为主表")]
        public string ParentTableId { get; set; }
    }
}