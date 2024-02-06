namespace OpenAuth.App.Request
{
    public class PageReq
    {
        /// <summary>
        /// 页码
        /// </summary>
        /// <example>1</example>
        public int page { get; set; }
        /// <summary>
        /// 每页条数
        /// </summary>
        /// <example>10</example>
        public int limit { get; set; }

        public string key { get; set; }

        public PageReq()
        {
            page = 1;
            limit = 10;
        }
    }
}
