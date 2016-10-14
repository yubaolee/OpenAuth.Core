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
        /// 页码
        /// </summary>
        public int page;
        /// <summary>
        /// 总页数
        /// </summary>
        public int total;
        /// <summary>
        /// 总记录条数
        /// </summary>
        public int records;

        /// <summary>
        /// 数据内容
        /// </summary>
        public dynamic rows;
    }
}