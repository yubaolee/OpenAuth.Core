namespace OpenAuth.App.Request
{
    public class QueryApproverReq
    {
        /// <summary>
        /// 获取或设置流程实例ID
        /// </summary>
        public string FlowInstanceId { get;set; }

        /// <summary>
        /// 节点Id
        /// </summary>
        public string ActivityId{ get;set; }

    }
}
