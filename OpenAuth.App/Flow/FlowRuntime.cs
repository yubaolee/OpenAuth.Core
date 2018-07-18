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

        /// <summary>
        /// 构造函数
        /// </summary>
        public FlowRuntime(FlowInstance instance)
        {
            dynamic schemeContentJson = instance.SchemeContent.ToJson();//获取工作流模板内容的json对象;
            frmData = instance.FrmData;
            lines = GetLines(schemeContentJson);
            nodes = GetNodes(schemeContentJson);//节点集合
            FromCurrentLines = GetFromLines(schemeContentJson);//线条集合
            ToCurrentLines = GetToLines(schemeContentJson);
            currentNodeId = (instance.ActivityId == "" ? startNodeId : instance.ActivityId);
            currentNodeType = GetNodeType(currentNodeId);

            title = schemeContentJson.title;
            initNum = schemeContentJson.initNum;

            //会签开始节点和流程结束节点没有下一步
            if (currentNodeType == 0 || currentNodeType == 4)
            {
                nextNodeId = "-1";
                nextNodeType = -1;
            }
            else
            {
                nextNodeId = GetNextNodeId(frmData);//下一个节点
                nextNodeType = GetNodeType(nextNodeId);
            }

            previousId = instance.PreviousId;
            flowInstanceId = instance.Id;

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
                    this.startNodeId = node.id;
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

        private  List<FlowLine> GetLines(dynamic schemeContentJson)
        {
            var lines = new List<FlowLine>();
            foreach (JObject item in schemeContentJson.lines)
            {
                lines.Add(item.ToObject<FlowLine>());

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
                LineList = FromCurrentLines[currentNodeId];
            }
            else
            {
                LineList = FromCurrentLines[nodeId];
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
        /// 获取实例接下来运行的状态
        /// </summary>
        /// <returns>-1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束</returns>
        public int GetNextNodeType()
        {
            if (nextNodeId != "-1")
            {
                return GetNodeType(nextNodeId);

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
            switch (nodes[nodeId].type)
            {
                //会签开始节点
                case FlowNode.FORK:
                    return 0;
                //会签结束节点
                case FlowNode.JOIN:
                    return 1;
                //结束节点
                case FlowNode.END:
                    return 4;
                //开始节点
                case FlowNode.START:
                    return 3;
                default:
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
            return FromCurrentLines[forknodeId].Select(item => item.to).ToList();
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

            int allnum = ToCurrentLines[joinNodeId].Count;   //总会签数量
          
            int i = 0;
            foreach (var item in nodes)
            {
                if (item.Key != joinNodeId)
                {
                    i++;
                    continue;
                }

                if (string.IsNullOrEmpty(item.Value.setInfo.NodeConfluenceType)) //默认所有步骤通过  
                {
                    if (tag.Taged == 1)
                    {
                        if (item.Value.setInfo.ConfluenceOk == null)
                        {
                            item.Value.setInfo.ConfluenceOk = 1;
                            res = "1";
                        }
                        else if (item.Value.setInfo.ConfluenceOk == (allnum - 1))  //会签成功
                        {
                            res = GetNextNode(joinNodeId);
                            if (res == "-1")
                            {
                                throw (new Exception("会签成功寻找不到下一个节点"));
                            }
                        }
                        else
                        {
                            item.Value.setInfo.ConfluenceOk++;
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
                //            schemeContentJson.nodes[i].setInfo.ConfluenceNo = 1;
                //            res = "1";
                //        }
                //        else if (item.setInfo.ConfluenceNo == (allnum - 1))
                //        {
                //            res = "-1";
                //        }
                //        else
                //        {
                //            schemeContentJson.nodes[i].setInfo.ConfluenceNo++;
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
                nextNodeId = res;
                nextNodeType = GetNodeType(res);
            }
            else
            {
                nextNodeId = joinNodeId;
                nextNodeType = GetNodeType(joinNodeId);
            }
            return res;
        }

        /// <summary>
        /// 驳回节点0"前一步"1"第一步"2"某一步" 3"不处理"
        /// </summary>
        /// <returns></returns>
        public string RejectNode()
        {
            return RejectNode(currentNodeId);
        }

        public string RejectNode(string nodeId)
        {
            dynamic node = nodes[nodeId];
            if (node.setInfo != null)
            {
                if (node.setInfo.NodeRejectType == "0")
                {
                    return previousId;
                }
                if (node.setInfo.NodeRejectType == "1")
                {
                    return GetNextNode(startNodeId);
                }
                if (node.setInfo.NodeRejectType == "2")
                {
                    return node.setInfo.NodeRejectStep;
                }
                return "";
            }
            return previousId;
        }
        ///<summary>
        /// 标记节点1通过，-1不通过，0驳回
        /// </summary>
        /// <param name="nodeId"></param>
        public void MakeTagNode(string nodeId, Tag tag)
        {
            foreach (var item in nodes)
            {
                if (item.Key == nodeId)
                {
                    item.Value.setInfo.Taged = tag.Taged;
                    item.Value.setInfo.UserId = tag.UserId;
                    item.Value.setInfo.UserName = tag.UserName;
                    item.Value.setInfo.Description = tag.Description;
                    item.Value.setInfo.TagedTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
                    break;
                }
            }
        }



        public string title { get; set; }

        public int initNum { get; set; }
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
        public FlowNode currentNode => nodes[currentNodeId];

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
        public FlowNode nextNode => nodes[nextNodeId];

        /// <summary>
        /// 上一个节点
        /// </summary>
        public string previousId { get; set; }

        /// <summary>
        /// 实例节点集合
        /// </summary>
        public Dictionary<string, FlowNode> nodes { get; set; }
        public List<FlowLine> lines { get; set; }
        /// <summary>
        /// 流转的线段集合
        /// </summary>
        public Dictionary<string, List<FlowLine>> FromCurrentLines { get; set; }

        public Dictionary<string, List<FlowLine>> ToCurrentLines { get; set; }

        /// <summary>
        /// 表单数据
        /// </summary>
        public string frmData { get; set; }

        public object ToSchemeObj()
        {
            return new
            {
                title = this.title,
                initNum = this.initNum,
                lines = lines,
                nodes = nodes.Select(u => u.Value),
                areas = new string[0]
            };
        }
    }
    #endregion
}

