using System.Collections.Generic;

namespace OpenAuth.App.Extention
{
    public interface IWF_Runtime
    {
        #region 工作流实例流转API
        /// <summary>
        /// 工作流实例运行信息
        /// </summary>
        /// <returns></returns>
        WF_RuntimeModel runtimeModel{get;}
        /// <summary>
        /// 获取实例接下来运行的状态
        /// </summary>
        /// <returns>-1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束</returns>
        int GetStatus();
        /// <summary>
        /// 获取节点类型 0会签开始,1会签结束,2一般节点,开始节点,4流程运行结束
        /// </summary>
        /// <param name="nodeId"></param>
        /// <returns></returns>
        int GetNodeStatus(string nodeId);
        /// <summary>
        /// 获取会签下面需要审核的ID列表
        /// </summary>
        /// <param name="shuntnodeId"></param>
        /// <returns></returns>
        List<string> GetCountersigningNodeIdList(string shuntnodeId);
        /// <summary>
        /// 通过节点Id获取下一个节点Id
        /// </summary>
        /// <param name="nodeId"></param>
        /// <returns></returns>
        string GetNextNodeByNodeId(string nodeId);
        /// <summary>
        /// 节点会签审核 
        /// </summary>
        /// <param name="nodeId"></param>
        /// <param name="flag"></param>
        /// <returns>-1不通过,1等待,其它通过</returns>
        string NodeConfluence(string nodeId, bool flag,string userId, string description = "");
        /// <summary>
        /// 驳回节点0"前一步"1"第一步"2"某一步" 3"不处理"
        /// </summary>
        /// <returns></returns>
        string RejectNode();
        /// <summary>
        /// 驳回节点0"前一步"1"第一步"2"某一步" 3"不处理"
        /// </summary>
        /// <param name="nodeId"></param>
        /// <returns></returns>
        string RejectNode(string nodeId);
        /// <summary>
        /// 标记节点1通过，-1不通过，0驳回
        /// </summary>
        /// <param name="nodeId"></param>
        /// <param name="flag"></param>
        /// <param name="userId"></param>
        /// <param name="description"></param>
        void MakeTagNode(string nodeId, int flag,string userId, string description = "");
        #endregion
    }
}
