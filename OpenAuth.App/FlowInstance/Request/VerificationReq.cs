using System.Collections.Generic;

namespace OpenAuth.App.Request
{
    public class VerificationReq : NodeDesignateReq
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
        
        /// <summary>
        /// 新的表单数据
        /// 如果该节点有可以修改的表单项时，会提交表单数据信息
        /// </summary>
        public string FrmData { get; set; }
        
    }
}
