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

namespace OpenAuth.App.Request
{
    /// <summary>
	/// 代码生成器的表信息
	/// </summary>
    public partial class AddOrUpdateBuilderTableReq 
    {
        /// <summary>
        /// Id为空则为添加
        /// </summary>
        public string Id { get; set; }
        
        /// <summary>
        /// 表英文全称
        /// </summary>
        public string TableName { get; set; }
        /// <summary>
        /// 表描述、中文名称
        /// </summary>
        public string Remark { get; set; }
        
        /// <summary>
        /// 父表ID
        /// </summary>
        public string ParentTableId { get; set; }
       
        /// <summary>
        /// 实体类名称
        /// </summary>
        public string ClassName { get; set; }
        /// <summary>
        /// 命名空间
        /// </summary>
        public string Namespace { get; set; }
        /// <summary>
        /// 模块标识
        /// </summary>
        public string ModuleCode { get; set; }
        /// <summary>
        /// 模块名称
        /// </summary>
        public string ModuleName { get; set; }
        /// <summary>
        /// 代码相对文件夹路径
        /// </summary>
        public string Folder { get; set; }
        /// <summary>
        /// 其它生成选项
        /// </summary>
        public string Options { get; set; }
        /// <summary>
        /// 分类ID
        /// </summary>
        public string TypeId { get; set; }
        /// <summary>
        /// 分类名称
        /// </summary>
        public string TypeName { get; set; }
        
        /// <summary>
        /// 是否动态加载表头信息
        /// </summary>
        public bool IsDynamicHeader { get; set; }
        
        
        /// <summary>
        /// 子表外键
        /// </summary>
        public string ForeignKey { get; set; }
    }
}