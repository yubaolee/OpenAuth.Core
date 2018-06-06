using System.Collections.Generic;

namespace OpenAuth.App.Flow
{
    public class FlowRuntimeModel
    {
        /// <summary>
        /// 运行实例的Id
        /// </summary>
        public string flowInstanceId { get; set; }
        /// <summary>
        /// 开始节点的ID
        /// </summary>
        public string startNodeId { get; set; }

        /// <summary>
        /// 当前节点的ID
        /// </summary>
        public string currentNodeId { get; set; }
        /// <summary>
        /// 当前节点类型 0会签开始,1会签结束,2一般节点,开始节点,4流程运行结束
        /// </summary>
        public int currentNodeType { get; set; }
        /// <summary>
        /// 当前节点的对象
        /// </summary>
        public FlowNode currentNode { get { return nodes[currentNodeId]; } }
        /// <summary>
        /// 下一个节点
        /// </summary>
        public string nextNodeId { get; set; }
        /// <summary>
        /// 下一个节点类型 -1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束
        /// </summary>
        /// <value>The type of the next node.</value>
        public int nextNodeType { get; set; }
        /// <summary>
        /// 下一个节点对象
        /// </summary>
        public FlowNode nextNode { get { return nodes[nextNodeId]; } }

        /// <summary>
        /// 上一个节点
        /// </summary>
        public string previousId { get; set; }

        /// <summary>
        /// 实例节点集合
        /// </summary>
        public Dictionary<string, FlowNode> nodes { get; set; }
        /// <summary>
        /// 流转的线段集合
        /// </summary>
        public Dictionary<string, List<FlowLine>> lines { get; set; }

        /// <summary>
        /// 模板json数据
        /// </summary>
        public dynamic schemeContentJson { get; set; }
        /// <summary>
        /// 表单数据
        /// </summary>
        public string frmData { get; set; }

    }

}
