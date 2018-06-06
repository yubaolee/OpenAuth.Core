namespace OpenAuth.App.Request
{
    public class VerificationReq
    {
        public string FlowInstanceId { get; set; }
        /// <summary>
        /// 1:同意；2：不同意；3：驳回
        /// </summary>
        public string VerificationFinally { get; set; }

        /// <summary>
        /// 审核意见
        /// </summary>
        public string VerificationOpinion { get; set; }

        /// <summary>
        /// 驳回的步骤，即驳回到的节点ID
        /// </summary>
        public string NodeRejectStep { get; set; }
    }
}
