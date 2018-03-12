namespace OpenAuth.App.Request
{
    public class QueryFlowInstanceListReq : PageReq
    {
        public string type { get; set; }
        public string userid { get; set; }
    }
}
