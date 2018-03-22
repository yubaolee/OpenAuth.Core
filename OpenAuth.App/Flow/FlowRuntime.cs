using System;
using System.Collections.Generic;
using Infrastructure;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Flow
{
    public class FlowRuntime
    {
        private FlowRuntimeModel _runtimeModel = null;

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="currentNodeId">当前节点</param>
        /// <param name="frmData">表单数据</param>
        /// <param name="instance"></param>
        public FlowRuntime(FlowInstance instance)
        {
            _runtimeModel = new FlowRuntimeModel();
            dynamic schemeContentJson = instance.SchemeContent.ToJson();//获取工作流模板内容的json对象;
            _runtimeModel.schemeContentJson = schemeContentJson;//模板流程json对象
            _runtimeModel.frmData = instance.FrmData;
            _runtimeModel.nodes = GetNodeDictionary(schemeContentJson);//节点集合
            _runtimeModel.lines = GetLineDictionary(schemeContentJson);//线条集合
            _runtimeModel.currentNodeId = (instance.ActivityId == "" ? _runtimeModel.startNodeId : instance.ActivityId);
            _runtimeModel.currentNodeType = GetNodeType(_runtimeModel.currentNodeId);

            if (_runtimeModel.currentNodeType == 0 || _runtimeModel.currentNodeType == 4)
            {
                _runtimeModel.nextNodeId = "-1";//下一个节点
                _runtimeModel.nextNodeType = -1;
            }
            else
            {
                _runtimeModel.nextNodeId = GetNextNode(_runtimeModel.frmData);//下一个节点
                _runtimeModel.nextNodeType = GetNodeType(_runtimeModel.nextNodeId);
            }

            _runtimeModel.previousId = instance.PreviousId;
            _runtimeModel.flowInstanceId = instance.Id;

        }

        #region 私有方法
        /// <summary>
        /// 获取工作流节点的字典列表:key节点id
        /// </summary>
        /// <param name="schemeContentJson"></param>
        /// <returns></returns>
        private Dictionary<string, FlowNode> GetNodeDictionary(dynamic schemeContentJson)
        {
            Dictionary<string, FlowNode> nodeDictionary = new Dictionary<string, FlowNode>();
            foreach (var item in schemeContentJson.Flow.nodes)
            {
                if (!nodeDictionary.ContainsKey(item.id.Value))
                {
                    nodeDictionary.Add(item.id.Value, item);
                }
                if (item.type == FlowNode.START)
                {
                    this._runtimeModel.startNodeId = item.id.Value;
                }
            }
            return nodeDictionary;
        }
        /// <summary>
        /// 获取工作流线段的字典列表:key开始节点id，value线条实体列表
        /// </summary>
        /// <param name="schemeContentJson"></param>
        /// <returns></returns>
        private Dictionary<string, List<FlowLine>> GetLineDictionary(dynamic schemeContentJson)
        {
            Dictionary<string, List<FlowLine>> lineDictionary = new Dictionary<string, List<FlowLine>>();
            foreach (var item in schemeContentJson.Flow.lines)
            {
                if (!lineDictionary.ContainsKey(item.from.Value))
                {
                    List<FlowLine> d = new List<FlowLine> { item };
                    lineDictionary.Add(item.from.Value, d);
                }
                else
                {
                    lineDictionary[item.from.Value].Add(item);
                }
            }
            return lineDictionary;
        }
        /// <summary>
        /// 获取工作流线段的字典列表:key开始节点id，value线条实体列表
        /// </summary>
        /// <param name="schemeContentJson"></param>
        /// <returns></returns>
        private Dictionary<string, List<FlowLine>> GetToLineDictionary(dynamic schemeContentJson)
        {
            Dictionary<string, List<FlowLine>> lineDictionary = new Dictionary<string, List<FlowLine>>();
            foreach (var item in schemeContentJson.Flow.lines)
            {
                if (!lineDictionary.ContainsKey(item.to.Value))
                {
                    List<FlowLine> d = new List<FlowLine> { item };
                    lineDictionary.Add(item.to.Value, d);
                }
                else
                {
                    lineDictionary[item.to.Value].Add(item);
                }
            }
            return lineDictionary;
        }

        /// <summary>
        /// 获取下一个节点
        /// </summary>
        /// <param name="frmData">表单数据（用于判断流转条件）</param>
        private string GetNextNode(string frmData, string nodeId = null)
        {
            List<FlowLine> LineList = null;
            if (nodeId == null)
            {
                LineList = runtimeModel.lines[runtimeModel.currentNodeId];
            }
            else
            {
                LineList = runtimeModel.lines[nodeId];
            }
            if (LineList.Count == 1)  //只有一条流程
            {
                return LineList[0].to;
            }

            if (frmData != "")  //有分支的情况
            {
                frmData = frmData.ToLower();//统一转小写
                var frmDataJson = frmData.ToJObject();//获取数据内容
                bool flag = false;
                foreach (var item in LineList)//轮训该节点所有连接的线路
                {

                    return item.to;



                }
            }
            return "-1";//表示寻找不到节点
        }
        #endregion

        #region 工作流实例流转API
        /// <summary>
        /// 工作流实例运行信息
        /// </summary>
        /// <returns></returns>
        public FlowRuntimeModel runtimeModel
        {
            get { return _runtimeModel; }
        }
        /// <summary>
        /// 获取实例接下来运行的状态
        /// </summary>
        /// <returns>-1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束</returns>
        public int GetNextNodeType()
        {
            if (_runtimeModel.nextNodeId != "-1")
            {
                return GetNodeType(_runtimeModel.nextNodeId);
                
            }
            return -1;
        }
        /// <summary>
        /// 获取节点类型 0会签开始,1会签结束,2一般节点,开始节点,4流程运行结束
        /// </summary>
        /// <param name="nodeId"></param>
        /// <returns></returns>
        public int GetNodeType(string nodeId)
        {
            if (_runtimeModel.nodes[nodeId].type == "shuntnode")//会签开始节点
            {
                return 0;
            }
            else if (_runtimeModel.nodes[nodeId].type == "confluencenode")//会签结束节点
            {
                return 1;
            }
            else if (_runtimeModel.nodes[nodeId].type == FlowNode.END)//结束节点
            {
                return 4;
            }
            else if (_runtimeModel.nodes[nodeId].type == FlowNode.START)//开始节点
            {
                return 3;
            }
            else
            {
                return 2;
            }
        }
        /// <summary>
        /// 获取会签下面需要审核的ID列表
        /// </summary>
        /// <param name="shuntnodeId"></param>
        /// <returns></returns>
        public List<string> GetCountersigningNodeIdList(string shuntnodeId)
        {
            List<string> list = new List<string>();

            List<FlowLine> listline = _runtimeModel.lines[shuntnodeId];

            foreach (var item in listline)
            {
                list.Add(item.to);
            }

            return list;
        }
        /// <summary>
        /// 通过节点Id获取下一个节点Id
        /// </summary>
        /// <param name="nodeId"></param>
        /// <returns></returns>
        public string GetNextNodeByNodeId(string nodeId)
        {
            string frmData = "";

            //     frmData = GetNodeFrmData(_getFrmData, nodeId);

            return GetNextNode(frmData, nodeId);
        }
        /// <summary>
        /// 节点会签审核 
        /// </summary>
        /// <param name="nodeId"></param>
        /// <param name="flag"></param>
        /// <returns>-1不通过,1等待,其它通过</returns>
        public string NodeConfluence(string nodeId, bool flag, string userId, string description = "")
        {
            string res = "-1";
            try
            {
                if (flag)
                {
                    MakeTagNode(nodeId, 1, userId, description);
                }
                else
                {
                    MakeTagNode(nodeId, -1, userId, description);
                }

                string _nextNodeId = GetNextNodeByNodeId(nodeId);//获取下一个节点
                if (_nextNodeId != "-1")
                {
                    Dictionary<string, List<FlowLine>> toLines = GetToLineDictionary(_runtimeModel.schemeContentJson);
                    int allnum = toLines[_nextNodeId].Count;
                    int i = 0;
                    foreach (var item in _runtimeModel.schemeContentJson.Flow.nodes)
                    {
                        if (item.id.Value == _nextNodeId)
                        {
                            if (item.setInfo.NodeConfluenceType.Value == "")//0所有步骤通过  todo:先用空格
                            {
                                if (flag)
                                {
                                    if (item.setInfo.ConfluenceOk == null)
                                    {
                                        _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.ConfluenceOk = 1;
                                        res = "1";
                                    }
                                    else if (item.setInfo.ConfluenceOk.Value == (allnum - 1))
                                    {
                                        res = GetNextNodeByNodeId(_nextNodeId);
                                        if (res == "-1")
                                        {
                                            throw (new Exception("会签成功寻找不到下一个节点"));
                                        }
                                    }
                                    else
                                    {
                                        _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.ConfluenceOk++;
                                        res = "1";
                                    }
                                }
                            }
                            else if (item.setInfo.NodeConfluenceType.Value == "1")//1一个步骤通过即可
                            {
                                if (flag)
                                {
                                    res = GetNextNodeByNodeId(_nextNodeId);
                                    if (res == "-1")
                                    {
                                        throw (new Exception("会签成功寻找不到下一个节点"));
                                    }
                                }
                                else
                                {
                                    if (item.setInfo.ConfluenceNo == null)
                                    {
                                        _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.ConfluenceNo = 1;
                                        res = "1";
                                    }
                                    else if (item.setInfo.ConfluenceNo.Value == (allnum - 1))
                                    {
                                        res = "-1";
                                    }
                                    else
                                    {
                                        _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.ConfluenceNo++;
                                        res = "1";
                                    }
                                }
                            }
                            else//2按百分比计算
                            {
                                if (flag)
                                {
                                    if (item.setInfo.ConfluenceOk == null)
                                    {
                                        _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.ConfluenceOk = 1;
                                    }
                                    else
                                    {
                                        _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.ConfluenceOk++;
                                    }
                                }
                                else
                                {
                                    if (item.setInfo.ConfluenceNo == null)
                                    {
                                        _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.ConfluenceNo = 1;
                                    }
                                    else
                                    {
                                        _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.ConfluenceNo++;
                                    }
                                }
                                if ((item.setInfo.ConfluenceNo.Value + item.setInfo.ConfluenceOk.Value) / allnum * 100 > int.Parse(item.setInfo.NodeConfluenceRate.Value))
                                {
                                    res = GetNextNodeByNodeId(_nextNodeId);
                                    if (res == "-1")
                                    {
                                        throw (new Exception("会签成功寻找不到下一个节点"));
                                    }
                                }
                                else if ((item.setInfo.ConfluenceNo.Value + item.setInfo.ConfluenceOk.Value) == allnum)
                                {
                                    res = "-1";
                                }
                                else
                                {
                                    res = "1";
                                }
                            }
                            break;
                        }
                        i++;
                    }
                    if (res == "-1")
                    {
                        MakeTagNode(_nextNodeId, -1, userId);
                    }
                    else if (res != "1")  //则时res是会签结束节点的ID
                    {
                        MakeTagNode(_nextNodeId, 1, userId);
                        _runtimeModel.nextNodeId = res;
                        _runtimeModel.nextNodeType = GetNodeType(res);
                    }
                    else
                    {
                        _runtimeModel.nextNodeId = _nextNodeId;
                        _runtimeModel.nextNodeType = GetNodeType(_nextNodeId);
                    }
                    return res;
                }
                else
                {
                    throw (new Exception("寻找不到会签下合流节点"));
                }
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 驳回节点0"前一步"1"第一步"2"某一步" 3"不处理"
        /// </summary>
        /// <returns></returns>
        public string RejectNode()
        {
            return RejectNode(_runtimeModel.currentNodeId);
        }
        /// <summary>
        /// 驳回节点0"前一步"1"第一步"2"某一步" 3"不处理"
        /// </summary>
        /// <param name="nodeId"></param>
        /// <returns></returns>
        public string RejectNode(string nodeId)
        {
            try
            {
                dynamic _node = _runtimeModel.nodes[nodeId];
                if (_node.setInfo != null)
                {
                    if (_node.setInfo.NodeRejectType.Value == "0")
                    {
                        return _runtimeModel.previousId;
                    }
                    else if (_node.setInfo.NodeRejectType.Value == "1")
                    {
                        return GetNextNodeByNodeId(_runtimeModel.startNodeId);
                    }
                    else if (_node.setInfo.NodeRejectType.Value == "2")
                    {
                        return _node.setInfo.NodeRejectStep.Value;
                    }
                    else
                    {
                        return "";
                    }

                }
                else//前一步
                {
                    return _runtimeModel.previousId;
                }
            }
            catch
            {
                throw;
            }
        }
        /// 标记节点1通过，-1不通过，0驳回
        /// </summary>
        /// <param name="nodeId"></param>
        /// <param name="flag"></param>
        /// <param name="userId"></param>
        /// <param name="description"></param>
        public void MakeTagNode(string nodeId, int flag, string userId, string description = "")
        {
            int i = 0;
            foreach (var item in _runtimeModel.schemeContentJson.Flow.nodes)
            {
                if (item.id.Value == nodeId)
                {
                    _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.Taged = flag;
                    _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.UserId = userId;
                    _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.description = description;
                    _runtimeModel.schemeContentJson.Flow.nodes[i].setInfo.TagedTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
                    break;
                }
                i++;
            }
        }
        #endregion
    }
}
