namespace OpenAuth.App.Request
{
    public class PageReq
    {
        public int page { get; set; }
        public int limit { get; set; }

        public string key { get; set; }

        public PageReq()
        {
            page = 1;
            limit = 10;
        }
    }
}
