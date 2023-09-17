namespace OpenAuth.App.Request
{
    /// <summary>
    /// 打印方案数据源请求参数
    /// </summary>
    public class QueryReq : PageReq
    {
        /// <summary>
        ///数据源;打印方案对应的数据来源SQL
        /// </summary>
        public string SourceSql { get; set; }

        /// <summary>
        /// 入口参数JSON字符串
        /// </summary>
        public string ParamJsonStr { get; set; }
    }
}
