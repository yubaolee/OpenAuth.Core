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
        
        /// <summary>
        /// 驳回类型。null:使用节点配置的驳回类型/0:前一步/1:第一步/2：指定节点，使用NodeRejectStep
        /// </summary>
        public string NodeRejectType { get; set; }
    }
}
