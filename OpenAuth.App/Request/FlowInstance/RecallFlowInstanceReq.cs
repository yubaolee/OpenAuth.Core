namespace OpenAuth.App.Request
{
    /// <summary>
    /// 召回、撤销流程
    /// </summary>
    public class RecallFlowInstanceReq
    {
        /// <summary>
        /// 召回、撤销的流程实例ID
        /// </summary>
        public string FlowInstanceId { get; set; }
        /// <summary>
        /// 撤回备注
        /// </summary>
        public string Description { get; set; }
        
    }
}
