namespace OpenAuth.App.Request
{
    public class QueryFlowInstanceHistoryReq : PageReq
    {
        /// <summary>
        /// 流程实体名称
        /// </summary>
        public string FlowInstanceId { get; set; }

    }
}
