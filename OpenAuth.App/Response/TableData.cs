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
        public int code;
        /// <summary>
        /// 操作消息
        /// </summary>
        public string msg;

        /// <summary>
        /// 总记录条数
        /// </summary>
        public int count;

        /// <summary>
        /// 数据内容
        /// </summary>
        public dynamic data;
    }
}