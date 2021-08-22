// ***********************************************************************
// Assembly         : FundationAdmin
// Author           : yubaolee
// Created          : 03-09-2016
//
// Last Modified By : yubaolee
// Last Modified On : 03-09-2016
// ***********************************************************************
// <copyright file="TableData.cs" company="Microsoft">
//     版权所有(C) Microsoft 2015
// </copyright>
// <summary>layui datatable数据返回</summary>
// ***********************************************************************

using System;
using System.Collections.Generic;
using Infrastructure;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Response
{
    /// <summary>
    /// table的返回数据
    /// </summary>
    public class TableData
    {
        /// <summary>
        /// 状态码
        /// </summary>
        public int code { get; set; }
        /// <summary>
        /// 操作消息
        /// </summary>
        public string msg { get; set; }

        /// <summary>
        /// 总记录条数
        /// </summary>
        public int count { get; set; }

        /// <summary>
        ///  返回的列表头信息（已过时，请使用columnFields代替）
        /// </summary>
        [Obsolete("请使用ColumnFields以获得更丰富的配置信息")]
        public List<KeyDescription> columnHeaders;
        
        /// <summary>
        ///  返回的表格列定义
        /// 该属性基于代码生成使用的列定义
        /// </summary>
        public List<BuilderTableColumn> columnFields;

        /// <summary>
        /// 数据内容
        /// </summary>
        public dynamic data { get; set; }

        public TableData()
        {
            code = 200;
            msg = "加载成功";
            columnHeaders = new List<KeyDescription>();
            columnFields = new List<BuilderTableColumn>();
        }
    }
}