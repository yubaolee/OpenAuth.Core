// ***********************************************************************
// Assembly         : FundationAdmin
// Author           : yubaolee
// Created          : 03-09-2016
//
// Last Modified By : yubaolee
// Last Modified On : 03-09-2016
// ***********************************************************************
// <copyright file="JqData.cs" company="Microsoft">
//     版权所有(C) Microsoft 2015
// </copyright>
// <summary>B-JUIDataGrid的数据格式</summary>
// ***********************************************************************

namespace OpenAuth.App.ViewModel
{
    /// <summary>
    /// jqGrid的返回值
    /// </summary>
    public class GridData
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