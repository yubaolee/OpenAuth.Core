namespace OpenAuth.App.Request
{
    public class QueryCategoryListReq : PageReq
    {
        /// <summary>
        /// 是否审核，all：全部； true:已审核；false：未审核
        /// </summary>
        public string Checked { get; set; }

        /// <summary>
        /// TypeID
        /// </summary>
        public string TypeId { get; set; }
    }
}