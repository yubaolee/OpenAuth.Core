using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Response
{
    public class FlowVerificationResp :FlowInstance
    {
        /// <summary>
        /// 预览表单数据
        /// </summary>
        /// <value>The FRM data HTML.</value>
        public string FrmPreviewHtml
        {
            get { return FormUtil.Preview(this); }
        }
        
        /// <summary>
        /// 下个节点的执行权限方式
        /// </summary>
        public string NextNodeDesignateType { get; set; }
    }
}
