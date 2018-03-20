namespace OpenAuth.App.Flow
{

    public class FlowRuntimeInitModel
    {
        /// <summary>
        /// GUID
        /// </summary>
        public string processId { get; set; }
        /// <summary>
        /// 工作流模板内容
        /// </summary>
        public string schemeContent { get; set; }
        /// <summary>
        /// 当前运行节点（默认开始节点）
        /// </summary>
        public string currentNodeId { get; set; }
        /// <summary>
        /// 提交的表单数据
        /// </summary>
        public string frmData { get; set; }
        /// <summary>
        /// 上一个节点
        /// </summary>
        public string previousId { get; set; }
    }
}
