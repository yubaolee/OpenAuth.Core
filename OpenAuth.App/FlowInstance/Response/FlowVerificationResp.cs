using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Response
{
    public class FlowVerificationResp :FlowInstance
    {
        /// <summary>
        /// 预览表单数据
        /// </summary>
        public string FrmPreviewHtml
        {
            get { return FormUtil.Preview(this); }
        }

        /// <summary>
        /// 预览表单数据表单项包含读写控制权限）
        /// </summary>
        public string FrmHtml
        {
            get { return FormUtil.GetHtml(this.FrmContentData, this.FrmContentParse, this.FrmData, "",this.CanWriteFormItemIds); }
        }
        
        /// <summary>
        /// 下个节点的执行权限方式
        /// </summary>
        public string NextNodeDesignateType { get; set; }
        
        /// <summary>
        /// 当前节点的可写表单Id
        /// </summary>
        public string[] CanWriteFormItemIds { get; set; }
    }
}
