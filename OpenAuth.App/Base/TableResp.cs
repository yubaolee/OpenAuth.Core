using System.Collections.Generic;
using Infrastructure;

namespace OpenAuth.App.Response
{
    /// <summary>
    /// 返回确定类型的表格数据，可以为swagger提供精准的注释
    /// </summary>
    public class TableResp<T>
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
        /// 数据内容
        /// </summary>
        public List<T> data { get; set; }
        
        /// <summary>
        ///  返回的列表头信息
        /// </summary>
        public List<KeyDescription> columnHeaders { get; set; }

        public TableResp()
        {
            code = 200;
            msg = "加载成功";
            columnHeaders = new List<KeyDescription>();
        }
    }
}