using System.Collections.Generic;

namespace OpenAuth.App.Extention
{
    public class WF_RuntimeModel
    {
        /// <summary>
        /// 运行实例的Id
        /// </summary>
        public string processId { get; set; }
        /// <summary>
        /// 开始节点的ID
        /// </summary>
        public string startNodeId { get; set; }
        /// <summary>
        /// 开始节点的对象
        /// </summary>
        public dynamic startNode { get { return this.nodeDictionary[this.startNodeId]; } }
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
        public dynamic currentNode { get { return this.nodeDictionary[this.currentNodeId]; } }
        /// <summary>
        /// 下一个节点
        /// </summary>
        public string nextNodeId { get; set; }
        /// <summary>
        /// 下一个节点类型
        /// </summary>
        public int nextNodeType { get; set; }
        /// <summary>
        /// 下一个节点对象
        /// </summary>
        public dynamic nextNode { get { return this.nodeDictionary[this.nextNodeId]; } }

        /// <summary>
        /// 上一个节点
        /// </summary>
        public string previousId { get; set; }
        /// <summary>
        /// 上一个节点
        /// </summary>
        public dynamic previousNode { get { return this.nodeDictionary[this.previousId]; } }
        /// <summary>
        /// 实例节点集合
        /// </summary>
        public Dictionary<string, dynamic> nodeDictionary { get; set; }
        /// <summary>
        /// 流转的线段集合
        /// </summary>
        public Dictionary<string, List<dynamic>> lineDictionary { get; set; }
        /// <summary>
        /// （建表的表单需要插入的数据表的语句）
        /// </summary>
        public string sqlFrm { get; set; }
        /// <summary>
        /// 模板json数据
        /// </summary>
        public dynamic schemeContentJson { get; set; }
        /// <summary>
        /// 表单数据
        /// </summary>
        public string frmData { get; set; }
        /// <summary>
        /// 表单类型(0自定义表单，1系统表单)
        /// </summary>
        public int frmType { get; set; }
    }

    public delegate string GetFrmData(string DataBaseId, string tableName, string tableFiled, string processId);
}
