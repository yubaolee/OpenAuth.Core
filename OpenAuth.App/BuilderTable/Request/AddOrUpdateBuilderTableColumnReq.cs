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
	/// 代码生成器的字段信息
	/// </summary>
    [Table("BuilderTableColumn")]
    public partial class AddOrUpdateBuilderTableColumnReq 
    {

        /// <summary>
        /// 编号
        /// </summary>
        public string Id { get; set; }
        /// <summary>
        /// 归属表编号
        /// </summary>
        public string TableId { get; set; }
        /// <summary>
        /// 表名称
        /// </summary>
        public string TableName { get; set; }
        /// <summary>
        /// 列名称
        /// </summary>
        public string ColumnName { get; set; }
        /// <summary>
        /// 列描述
        /// </summary>
        public string Remark { get; set; }
        /// <summary>
        /// 列类型
        /// </summary>
        public string ColumnType { get; set; }
        /// <summary>
        /// 实体类型
        /// </summary>
        public string EntityType { get; set; }
        /// <summary>
        /// 实体名称
        /// </summary>
        public string EntityName { get; set; }
        /// <summary>
        /// 是否主键
        /// </summary>
        public bool IsKey { get; set; }
        /// <summary>
        /// 是否自增
        /// </summary>
        public bool IsIncrement { get; set; }
        /// <summary>
        /// 是否必填
        /// </summary>
        public bool IsRequired { get; set; }
        /// <summary>
        /// 是否为插入字段
        /// </summary>
        public bool IsInsert { get; set; }
        /// <summary>
        /// 是否编辑字段
        /// </summary>
        public bool IsEdit { get; set; }
        /// <summary>
        /// 是否列表字段
        /// </summary>
        public bool IsList { get; set; }
        /// <summary>
        /// 是否查询字段
        /// </summary>
        public bool IsQuery { get; set; }
        /// <summary>
        /// 查询方式（等于、不等于、大于、小于、范围）
        /// </summary>
        public string QueryType { get; set; }
        /// <summary>
        /// 显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）
        /// </summary>
        public string HtmlType { get; set; }
        /// <summary>
        /// 编辑类型（文本框、文本域、下拉框、复选框、单选框、日期控件）
        /// </summary>
        public string EditType { get; set; }
        /// <summary>
        /// 排序
        /// </summary>
        public int Sort { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public System.DateTime CreateTime { get; set; }
        /// <summary>
        /// 创建人ID
        /// </summary>
        public string CreateUserId { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public System.DateTime? UpdateTime { get; set; }
        /// <summary>
        /// 修改人ID
        /// </summary>
        public string UpdateUserId { get; set; }
        /// <summary>
        /// 修改时的行位置
        /// </summary>
        public int? EditRow { get; set; }
        /// <summary>
        /// 修改时的列位置
        /// </summary>
        public int? EditCol { get; set; }
        /// <summary>
        /// 修改人姓名
        /// </summary>
        public string UpdateUserName { get; set; }
        /// <summary>
        /// 创建人姓名
        /// </summary>
        public string CreateUserName { get; set; }
        /// <summary>
        /// 最大长度
        /// </summary>
        public int? MaxLength { get; set; }
        
        /// <summary>
        /// 数据源（用于下拉框、复选框等取值）
        /// </summary>
        public string DataSource { get; set; }
        
         //todo:添加自己的请求字段
    }
}