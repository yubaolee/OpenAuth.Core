using System;
using System.Collections.Generic;
using System.Text;
using Infrastructure;

namespace OpenAuth.App.Extention
{
    public class WF_Runtime : IWF_Runtime
    {
        private WF_RuntimeModel _runtimeModel = null;

        private GetFrmData _getFrmData = null;
        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="schemeContent">流程模板</param>
        /// <param name="currentNodeId">当前节点</param>
        /// <param name="frmData">表单数据</param>
        public WF_Runtime(WF_RuntimeInitModel wfRuntimeInitModel,GetFrmData getFrmData = null)
        {
            _runtimeModel = new WF_RuntimeModel();
            _getFrmData = getFrmData;
            dynamic schemeContentJson = wfRuntimeInitModel.schemeContent.ToJson();//获取工作流模板内容的json对象;
            _runtimeModel.schemeContentJson = schemeContentJson;//模板流程json对象
            _runtimeModel.nodeDictionary = GetNodeDictionary(schemeContentJson);//节点集合
            _runtimeModel.lineDictionary = GetLineDictionary(schemeContentJson);//线条集合
            _runtimeModel.currentNodeId = (wfRuntimeInitModel.currentNodeId == "" ? _runtimeModel.startNodeId : wfRuntimeInitModel.currentNodeId);
            _runtimeModel.currentNodeType = GetNodeStatus(_runtimeModel.currentNodeId);
            _runtimeModel.frmData = wfRuntimeInitModel.frmData;
            if (getFrmData != null)
            {
                _runtimeModel.frmType = 1;
                wfRuntimeInitModel.frmData = GetNodeFrmData(getFrmData);
            }
            else
            {
                _runtimeModel.frmType = 0;
            }

            if (_runtimeModel.currentNodeType == 0 || _runtimeModel.currentNodeType == 4)
            {
                _runtimeModel.nextNodeId = "-1";//下一个节点
                _runtimeModel.nextNodeType = -1;
            }
            else
            {
                _runtimeModel.nextNodeId = GetNextNode(wfRuntimeInitModel.frmData);//下一个节点
                _runtimeModel.nextNodeType = GetNodeStatus(_runtimeModel.nextNodeId);
            }

            _runtimeModel.previousId = wfRuntimeInitModel.previousId;

            _runtimeModel.processId = wfRuntimeInitModel.processId.ToString();
            _runtimeModel.sqlFrm = SqlBuider(schemeContentJson, wfRuntimeInitModel.frmData, wfRuntimeInitModel.processId.ToString());

        }

        #region 私有方法
        /// <summary>
        /// 获取工作流节点的字典列表:key节点id
        /// </summary>
        /// <param name="schemeContentJson"></param>
        /// <returns></returns>
        private Dictionary<string, dynamic> GetNodeDictionary(dynamic schemeContentJson)
        {
            Dictionary<string, dynamic> nodeDictionary = new Dictionary<string, dynamic>();
            foreach (var item in schemeContentJson.Flow.nodes)
            {
                if (!nodeDictionary.ContainsKey(item.id.Value))
                {
                    nodeDictionary.Add(item.id.Value, item);
                }
                if (item.type == "startround")
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
        private Dictionary<string, List<dynamic>> GetLineDictionary(dynamic schemeContentJson)
        {
            Dictionary<string, List<dynamic>> lineDictionary = new Dictionary<string, List<dynamic>>();
            foreach (var item in schemeContentJson.Flow.lines)
            {
                if (!lineDictionary.ContainsKey(item.from.Value))
                {
                    List<dynamic> d = new List<dynamic>();
                    d.Add(item);
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
        private Dictionary<string, List<dynamic>> GetToLineDictionary(dynamic schemeContentJson)
        {
            Dictionary<string, List<dynamic>> lineDictionary = new Dictionary<string, List<dynamic>>();
            foreach (var item in schemeContentJson.Flow.lines)
            {
                if (!lineDictionary.ContainsKey(item.to.Value))
                {
                    List<dynamic> d = new List<dynamic>();
                    d.Add(item);
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
        /// 工作流流转条件比较函数
        /// </summary>
        /// <param name="frmvalue">表单数据</param>
        /// <param name="operation"></param>
        /// <param name="paramValue"></param>
        /// <returns></returns>
        private bool LineCompared(string frmvalue, string operation, string paramValue)
        {
            bool res = false;
            switch (operation)
            {
                case "Equal"://等于
                    if (decimal.Parse(frmvalue) == decimal.Parse(paramValue))
                    {
                        res = true;
                    }
                    break;
                case "NotEqual"://不等于
                    if (decimal.Parse(frmvalue) != decimal.Parse(paramValue))
                    {
                        res = true;
                    }
                    break;
                case "Greater"://大于
                    if (decimal.Parse(frmvalue) > decimal.Parse(paramValue))
                    {
                        res = true;
                    }
                    break;
                case "GreaterThan"://大于等于
                    if (decimal.Parse(frmvalue) >= decimal.Parse(paramValue))
                    {
                        res = true;
                    }
                    break;
                case "Less"://小于
                    if (decimal.Parse(frmvalue) < decimal.Parse(paramValue))
                    {
                        res = true;
                    }
                    break;
                case "LessThan"://小于等于
                    if (decimal.Parse(frmvalue) <= decimal.Parse(paramValue))
                    {
                        res = true;
                    }
                    break;
                case "Null"://为空
                    if (string.IsNullOrEmpty(frmvalue))
                    {
                        res = true;
                    }
                    break;
                case "NotNull"://不为空
                    if (!string.IsNullOrEmpty(frmvalue))
                    {
                        res = true;
                    }
                    break;
                case "Like"://包含
                    if (frmvalue.IndexOf(paramValue) != -1)
                    {
                        res = true;
                    }
                    break;
                case "NotLike"://不包含
                    if (frmvalue.IndexOf(paramValue) == -1)
                    {
                        res = true;
                    }
                    break;
            }
            return res;
        }

        /// <summary>
        /// 获取SQL语句
        /// </summary>
        /// <param name="tablename"></param>
        /// <param name="frmData"></param>
        /// <returns></returns>
        private string SqlBuider(dynamic schemeContentJson, string frmData, string keyValue)
        {
            return "";
            try
            {
                if (schemeContentJson.Frm.isSystemTable.Value == 1)
                {
                    var strSql = new StringBuilder();
                    var frmDataParam = frmData.ToJObject();
                    string sqlname = schemeContentJson.Frm.FrmTableId.Value, sqlvalues = "'" + keyValue + "'";
                    foreach (var item in frmDataParam)
                    {
                        if (item.Key != "__RequestVerificationToken")
                        {
                            sqlname += "," + item.Key;
                            if (item.Value.Type.ToString() == "String")
                            {
                                sqlvalues += ",'" + item.Value + "'";
                            }
                            else
                            {
                                sqlvalues += "," + item.Value;
                            }
                        }
                    }
                    strSql.Append(string.Format("insert into " + schemeContentJson.Frm.FrmTable.Value + " ({0})values({1})", sqlname, sqlvalues));
                    return strSql.ToString();
                }
                else
                {
                    return "";
                }
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 系统表单获取表单数据
        /// </summary>
        /// <param name="getFrmData"></param>
        /// <param name="nodeId"></param>
        /// <returns></returns>
        private string GetNodeFrmData(GetFrmData getFrmData,string nodeId = null)
        {
            try
            {
                string _nodeId = (nodeId == null ? _runtimeModel.currentNodeId : nodeId);
                dynamic _node = _runtimeModel.nodeDictionary[_nodeId];
                if (_node.setInfo != null)
                {
                    return getFrmData(_node.setInfo.NodeDataBase.Value, _node.setInfo.NodeTable.Value, _node.setInfo.NodePram.Value, _runtimeModel.processId);
                }
                else
                {
                    return "";
                }
                
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 获取下一个节点
        /// </summary>
        /// <param name="frmData">表单数据（用于判断流转条件）</param>
        private string GetNextNode(string frmData,string nodeId = null)
        {
            try
            {
                List<dynamic> LineList = null;
                if (nodeId == null)
                {
                    LineList = runtimeModel.lineDictionary[runtimeModel.currentNodeId];
                }
                else
                {
                    LineList = runtimeModel.lineDictionary[nodeId];
                }
                if (LineList.Count == 1)
                {
                    return LineList[0].to.Value;
                }
                else if (frmData != "")
                {
                    frmData = frmData.ToLower();//统一转小写
                    var frmDataJson = frmData.ToJObject();//获取数据内容
                    bool flag = false;
                    foreach (var item in LineList)//轮训该节点所有连接的线路
                    {
                        if (item.setInfo == null)//表示该线路没有设置条件，所以流转到下一个节点
                        {
                            return item.to.Value;
                        }
                        foreach (var _item in item.setInfo.ConditionValueJson)//轮询该线条上的所有条件
                        {
                            if (!string.IsNullOrEmpty(frmDataJson[_item.ParamName.Value.ToLower()].Value))
                            {
                                string frmvalue = frmDataJson[_item.ParamName.Value.ToLower()].ToString();
                                string operation = _item.Operation.Value;
                                string paramValue = _item.ParamValue.Value;
                                bool compareValue = LineCompared(frmvalue, operation, paramValue);

                                if (_item.Operation.Value == "AND")
                                {
                                    flag = compareValue;
                                    if (!compareValue)
                                    {
                                        break;
                                    }
                                }
                                else
                                {
                                    if (compareValue)
                                    {
                                        flag = compareValue;
                                    }
                                }
                            }
                        }
                        if (flag)//如果满足条件，
                        {
                            return item.to.Value;
                        }
                    }
                }
                return "-1";//表示寻找不到节点
            }
            catch
            {
                throw;
            }
        }
        #endregion

        #region 工作流实例流转API
        /// <summary>
        /// 工作流实例运行信息
        /// </summary>
        /// <returns></returns>
        public WF_RuntimeModel runtimeModel
        {
            get { return _runtimeModel; }
        }
        /// <summary>
        /// 获取实例接下来运行的状态
        /// </summary>
        /// <returns>-1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束</returns>
        public int GetStatus()
        {
            if (_runtimeModel.nextNodeId != "-1")
            {
                if (_runtimeModel.nextNode.type == "shuntnode")//会签开始节点
                {
                    return 0;
                }
                else if (_runtimeModel.nextNode.type == "confluencenode")//会签结束节点
                {
                    return 1;
                }
                else if (_runtimeModel.nextNode.type == "endround")//结束节点
                {
                    return 4;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return -1;
            }
        }
        /// <summary>
        /// 获取节点类型 0会签开始,1会签结束,2一般节点,开始节点,4流程运行结束
        /// </summary>
        /// <param name="nodeId"></param>
        /// <returns></returns>
        public int GetNodeStatus(string nodeId)
        {
            if (_runtimeModel.nodeDictionary[nodeId].type == "shuntnode")//会签开始节点
            {
                return 0;
            }
            else if (_runtimeModel.nodeDictionary[nodeId].type == "confluencenode")//会签结束节点
            {
                return 1;
            }
            else if (_runtimeModel.nodeDictionary[nodeId].type == "endround")//结束节点
            {
                return 4;
            }
            else if (_runtimeModel.nodeDictionary[nodeId].type == "startround")//开始节点
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
            try
            {
                List<string> list = new List<string>();

                List<dynamic> listline = _runtimeModel.lineDictionary[shuntnodeId];

                foreach (var item in listline)
                {
                    list.Add(item.to.Value);
                }

                return list;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 通过节点Id获取下一个节点Id
        /// </summary>
        /// <param name="nodeId"></param>
        /// <returns></returns>
        public string GetNextNodeByNodeId(string nodeId)
        {
            try
            {
                string frmData = "";
                if (_runtimeModel.frmType == 0)
                {
                    frmData = _runtimeModel.frmData;
                }
                else
                {
                    frmData = GetNodeFrmData(_getFrmData, nodeId);
                }
                return GetNextNode(frmData, nodeId);
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 节点会签审核 
        /// </summary>
        /// <param name="nodeId"></param>
        /// <param name="flag"></param>
        /// <returns>-1不通过,1等待,其它通过</returns>
        public string NodeConfluence(string nodeId, bool flag,string userId, string description = "")
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
                    Dictionary<string, List<dynamic>> toLines = GetToLineDictionary(_runtimeModel.schemeContentJson);
                    int allnum = toLines[_nextNodeId].Count;
                    int i = 0;
                    foreach (var item in _runtimeModel.schemeContentJson.Flow.nodes)
                    {
                        if (item.id.Value == _nextNodeId)
                        {
                            if(item.setInfo.NodeConfluenceType.Value == "")//0所有步骤通过  todo:先用空格
                            {
                                if(flag)
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
                            else if(item.setInfo.NodeConfluenceType.Value == "1")//1一个步骤通过即可
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
                        _runtimeModel.nextNodeType = GetNodeStatus(res);
                    }
                    else
                    {
                        _runtimeModel.nextNodeId = _nextNodeId;
                        _runtimeModel.nextNodeType = GetNodeStatus(_nextNodeId);
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
                dynamic _node = _runtimeModel.nodeDictionary[nodeId];
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
