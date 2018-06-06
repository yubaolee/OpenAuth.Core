using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using Newtonsoft.Json.Linq;
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
            _runtimeModel.frmData = instance.FrmData;
            _runtimeModel.schemeContentJson = schemeContentJson;//模板流程json对象
            _runtimeModel.nodes = GetNodes(schemeContentJson);//节点集合
            _runtimeModel.lines = GetFromLines(schemeContentJson);//线条集合
            _runtimeModel.currentNodeId = (instance.ActivityId == "" ? _runtimeModel.startNodeId : instance.ActivityId);
            _runtimeModel.currentNodeType = GetNodeType(_runtimeModel.currentNodeId);

            //会签开始节点和流程结束节点没有下一步
            if (_runtimeModel.currentNodeType == 0 || _runtimeModel.currentNodeType == 4)
            {
                _runtimeModel.nextNodeId = "-1";
                _runtimeModel.nextNodeType = -1;
            }
            else
            {
                _runtimeModel.nextNodeId = GetNextNodeId(_runtimeModel.frmData);//下一个节点
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
        private Dictionary<string, FlowNode> GetNodes(dynamic schemeContentJson)
        {
            Dictionary<string, FlowNode> nodes = new Dictionary<string, FlowNode>();
            foreach (JObject item in schemeContentJson.nodes)
            {
                var node = item.ToObject<FlowNode>();
                if (!nodes.ContainsKey(node.id))
                {
                    nodes.Add(node.id, node);
                }
                if (node.type == FlowNode.START)
                {
                    this._runtimeModel.startNodeId = node.id;
                }
            }
            return nodes;
        }
        /// <summary>
        /// 获取工作流节点及以节点为出发点的流程
        /// </summary>
        /// <param name="schemeContentJson"></param>
        /// <returns></returns>
        private Dictionary<string, List<FlowLine>> GetFromLines(dynamic schemeContentJson)
        {
            Dictionary<string, List<FlowLine>> lines = new Dictionary<string, List<FlowLine>>();
            foreach (JObject item in schemeContentJson.lines)
            {
                var line = item.ToObject<FlowLine>();
                if (!lines.ContainsKey(line.from))
                {
                    List<FlowLine> d = new List<FlowLine> { line };
                    lines.Add(line.from, d);
                }
                else
                {
                    lines[line.from].Add(line);
                }
            }
            return lines;
        }
        /// <summary>
        /// 获取工作流节点的入口流程列表
        /// </summary>
        /// <param name="schemeContentJson"></param>
        /// <returns></returns>
        private Dictionary<string, List<FlowLine>> GetToLines(dynamic schemeContentJson)
        {
            Dictionary<string, List<FlowLine>> lines = new Dictionary<string, List<FlowLine>>();
            foreach (JObject item in schemeContentJson.lines)
            {
                var line = item.ToObject<FlowLine>();
                if (!lines.ContainsKey(line.to))
                {
                    List<FlowLine> d = new List<FlowLine> { line };
                    lines.Add(line.to, d);
                }
                else
                {
                    lines[line.to].Add(line);
                }
            }
            return lines;
        }

        /// <summary>
        /// 获取下一个节点
        /// </summary>
        private string GetNextNodeId(string frmData, string nodeId=null)
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

        /// <summary>
        /// 通过节点Id获取下一个节点Id
        /// </summary>
        /// <param name="nodeId"></param>
        /// <returns></returns>
        public string GetNextNode(string nodeId)
        {
            string frmData = "";

            //     frmData = GetNodeFrmData(_getFrmData, nodeId);

            return GetNextNodeId(frmData, nodeId);
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
            if (_runtimeModel.nodes[nodeId].type == FlowNode.FORK)//会签开始节点
            {
                return 0;
            }
            else if (_runtimeModel.nodes[nodeId].type == FlowNode.JOIN)//会签结束节点
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
        /// <param name="forknodeId">会签开始节点</param>
        /// <returns></returns>
        public List<string> GetCountersigningNodeIdList(string forknodeId)
        {
            return _runtimeModel.lines[forknodeId].Select(item => item.to).ToList();
        }
        
        /// <summary>
        /// 节点会签审核 
        /// </summary>
        /// <param name="nodeId"></param>
        /// <param name="tag"></param>
        /// <returns>-1不通过,1等待,其它通过</returns>
        public string NodeConfluence(string nodeId, Tag tag)
        {
            string res = "-1";
            string joinNodeId = GetNextNode(nodeId); //获取回签的合流节点

            if (joinNodeId == "-1")
            {
                throw (new Exception("寻找不到会签下合流节点"));
            }

            Dictionary<string, List<FlowLine>> toLines = GetToLines(_runtimeModel.schemeContentJson);
            int allnum = toLines[joinNodeId].Count;   //总会签数量
          
            int i = 0;
            foreach (var item in _runtimeModel.schemeContentJson.nodes)
            {
                if (item.id != joinNodeId)
                {
                    i++;
                    continue;
                }

                if (string.IsNullOrEmpty(item.setInfo.NodeConfluenceType)) //默认所有步骤通过  
                {
                    if (tag.Taged == 1)
                    {
                        if (item.setInfo.ConfluenceOk == null)
                        {
                            _runtimeModel.schemeContentJson.nodes[i].setInfo.ConfluenceOk = 1;
                            res = "1";
                        }
                        else if (item.setInfo.ConfluenceOk == (allnum - 1))  //会签成功
                        {
                            res = GetNextNode(joinNodeId);
                            if (res == "-1")
                            {
                                throw (new Exception("会签成功寻找不到下一个节点"));
                            }
                        }
                        else
                        {
                            _runtimeModel.schemeContentJson.nodes[i].setInfo.ConfluenceOk++;
                            res = "1";
                        }
                    }
                }
                //else if (item.setInfo.NodeConfluenceType == "1") //1一个步骤通过即可
                //{
                //    if (tag.Taged == 1)
                //    {
                //        res = GetNextNodeId(nextNodeId);
                //        if (res == "-1")
                //        {
                //            throw (new Exception("会签成功寻找不到下一个节点"));
                //        }
                //    }
                //    else
                //    {
                //        if (item.setInfo.ConfluenceNo == null)
                //        {
                //            _runtimeModel.schemeContentJson.nodes[i].setInfo.ConfluenceNo = 1;
                //            res = "1";
                //        }
                //        else if (item.setInfo.ConfluenceNo == (allnum - 1))
                //        {
                //            res = "-1";
                //        }
                //        else
                //        {
                //            _runtimeModel.schemeContentJson.nodes[i].setInfo.ConfluenceNo++;
                //            res = "1";
                //        }
                //    }
                //}
            }



            if (res == "-1")
            {
                tag.Taged = -1;
                MakeTagNode(joinNodeId, tag);
            }
            else if (res != "1") //这时res是会签结束节点后面的一个节点
            {
                tag.Taged = 1;
                MakeTagNode(joinNodeId, tag);
                _runtimeModel.nextNodeId = res;
                _runtimeModel.nextNodeType = GetNodeType(res);
            }
            else
            {
                _runtimeModel.nextNodeId = joinNodeId;
                _runtimeModel.nextNodeType = GetNodeType(joinNodeId);
            }
            return res;
        }

        /// <summary>
        /// 驳回节点0"前一步"1"第一步"2"某一步" 3"不处理"
        /// </summary>
        /// <returns></returns>
        public string RejectNode()
        {
            return RejectNode(_runtimeModel.currentNodeId);
        }

        public string RejectNode(string nodeId)
        {
            dynamic node = _runtimeModel.nodes[nodeId];
            if (node.setInfo != null)
            {
                if (node.setInfo.NodeRejectType == "0")
                {
                    return _runtimeModel.previousId;
                }
                if (node.setInfo.NodeRejectType == "1")
                {
                    return GetNextNode(_runtimeModel.startNodeId);
                }
                if (node.setInfo.NodeRejectType == "2")
                {
                    return node.setInfo.NodeRejectStep;
                }
                return "";
            }
            return _runtimeModel.previousId;
        }
        ///<summary>
        /// 标记节点1通过，-1不通过，0驳回
        /// </summary>
        /// <param name="nodeId"></param>
        public void MakeTagNode(string nodeId, Tag tag)
        {
            int i = 0;
            foreach (var item in _runtimeModel.schemeContentJson.nodes)
            {
                if (item.id == nodeId)
                {
                    _runtimeModel.schemeContentJson.nodes[i].setInfo.Taged = tag.Taged;
                    _runtimeModel.schemeContentJson.nodes[i].setInfo.UserId = tag.UserId;
                    _runtimeModel.schemeContentJson.nodes[i].setInfo.UserName = tag.UserName;
                    _runtimeModel.schemeContentJson.nodes[i].setInfo.Description = tag.Description;
                    _runtimeModel.schemeContentJson.nodes[i].setInfo.TagedTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
                    break;
                }
                i++;
            }
        }
    }
    #endregion
}

