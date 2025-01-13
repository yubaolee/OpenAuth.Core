using Infrastructure;
using Newtonsoft.Json.Linq;
using OpenAuth.Repository.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using Castle.Core.Internal;
using Infrastructure.Const;
using Infrastructure.Extensions;
using Infrastructure.Extensions.AutofacManager;
using Infrastructure.Helpers;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using SqlSugar;

namespace OpenAuth.App.Flow
{
    /// <summary>
    /// 一个正在运行中的流程实例
    /// <para>该类只能通过new实例化，禁止通过容器获取</para>
    /// </summary>
    public class FlowRuntime
    {
        public FlowRuntime(FlowInstance instance)
        {
            dynamic schemeContentJson = instance.SchemeContent.ToJson(); //获取工作流模板内容的json对象;

            InitLines(schemeContentJson);
            InitNodes(schemeContentJson);

            currentNodeId = instance.ActivityId == "" ? startNodeId : instance.ActivityId;
            currentNodeType = GetNodeType(currentNodeId);
            FrmData = instance.FrmData;
            title = schemeContentJson.title;
            initNum = schemeContentJson.initNum ?? 0;
            previousId = instance.PreviousId;
            flowInstanceId = instance.Id;

            //会签开始节点和流程结束节点没有下一步
            if (currentNodeType == 0 || currentNodeType == 4)
            {
                nextNodeId = "-1";
                nextNodeType = -1;
            }
            else
            {
                nextNodeId = GetNextNodeId(); //下一个节点
                nextNodeType = GetNodeType(nextNodeId);
            }
        }

        #region 私有方法

        /// <summary>
        /// 获取工作流节点的字典列表:key节点id
        /// </summary>
        /// <param name="schemeContentJson"></param>
        /// <returns></returns>
        private void InitNodes(dynamic schemeContentJson)
        {
            Nodes = new Dictionary<string, FlowNode>();
            foreach (JObject item in schemeContentJson.nodes)
            {
                var node = item.ToObject<FlowNode>();
                if (!Nodes.ContainsKey(node.id))
                {
                    Nodes.Add(node.id, node);
                }

                if (node.type == FlowNode.START)
                {
                    this.startNodeId = node.id;
                }
            }
        }

        private void InitLines(dynamic schemeContentJson)
        {
            Lines = new List<FlowLine>();
            FromNodeLines = new Dictionary<string, List<FlowLine>>();
            ToNodeLines = new Dictionary<string, List<FlowLine>>();
            foreach (JObject item in schemeContentJson.lines)
            {
                var line = item.ToObject<FlowLine>();
                Lines.Add(line);

                if (!FromNodeLines.ContainsKey(line.from))
                {
                    List<FlowLine> d = new List<FlowLine> { line };
                    FromNodeLines.Add(line.from, d);
                }
                else
                {
                    FromNodeLines[line.from].Add(line);
                }

                if (!ToNodeLines.ContainsKey(line.to))
                {
                    List<FlowLine> d = new List<FlowLine> { line };
                    ToNodeLines.Add(line.to, d);
                }
                else
                {
                    ToNodeLines[line.to].Add(line);
                }
            }
        }

        /// <summary>
        /// 获取下一个节点
        /// </summary>
        private string GetNextNodeId(string nodeId = null)
        {
            var lines = nodeId == null ? FromNodeLines[currentNodeId] : FromNodeLines[nodeId];
            if (lines.Count == 0)
            {
                throw new Exception("无法寻找到下一个节点");
            }

            if (FrmData == "" || FrmData == "{}") return lines[0].to;

            FrmData = FrmData.ToLower(); //统一转小写
            var frmDataJson = FrmData.ToJObject(); //获取数据内容

            foreach (var l in lines)
            {
                if (!l.Compares.IsNullOrEmpty() && l.Compare(frmDataJson))
                {
                    return l.to;
                }
            }

            return lines[0].to;
        }

        #endregion 私有方法

        #region 共有方法

        //获取下一个节点
        public FlowNode GetNextNode(string nodeId = null)
        {
            return Nodes[GetNextNodeId(nodeId)];
        }

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
            switch (Nodes[nodeId].type)
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
        /// 节点会签审核
        /// </summary>
        /// <param name="nodeId">会签时，currentNodeId是会签开始节点。这个表示当前正在处理的节点</param>
        /// <param name="tag"></param>
        /// <returns>-1不通过,1等待,其它通过</returns>
        public string NodeConfluence(HttpClient httpClient, Tag tag)
        {
            var user = AutofacContainerModule.GetService<IAuth>().GetCurrentUser().User;
            //会签时的【当前节点】一直是会签开始节点
            //TODO: 标记会签节点的状态，这个地方感觉怪怪的
            MakeTagNode(currentNodeId, tag);

            string canCheckId = ""; //寻找当前登录用户可审核的节点Id
            foreach (string fromForkStartNodeId in FromNodeLines[currentNodeId]
                         .Select(u => u.to))
            {
                var fromForkStartNode = Nodes[fromForkStartNodeId]; //与会前开始节点直接连接的节点
                canCheckId = GetOneForkLineCanCheckNodeId(fromForkStartNode, tag);
                if (!string.IsNullOrEmpty(canCheckId)) break;
            }

            if (canCheckId == "")
            {
                throw new Exception("审核异常,找不到审核节点");
            }

            var content =
                $"{user.Account}-{DateTime.Now:yyyy-MM-dd HH:mm}审批了【{Nodes[canCheckId].name}】" +
                $"结果：{(tag.Taged == 1 ? "同意" : "不同意")}，备注：{tag.Description}";
            SaveOperationHis(content);

            MakeTagNode(canCheckId, tag); //标记审核节点状态

            var forkNode = Nodes[currentNodeId]; //会签开始节点
            FlowNode nextNode = GetNextNode(canCheckId); //获取当前处理的下一个节点

            int forkNumber = FromNodeLines[currentNodeId].Count; //直接与会签节点连接的点，即会签分支数目
            string res = string.Empty; //记录会签的结果,默认正在会签
            if (forkNode.setInfo.NodeConfluenceType == "one") //有一个步骤通过即可
            {
                if (tag.Taged == (int)TagState.Ok)
                {
                    if (nextNode.type == FlowNode.JOIN) //下一个节点是会签结束，则该线路结束
                    {
                        res = GetNextNodeId(nextNode.id);
                    }
                }
                else if (tag.Taged == (int)TagState.No)
                {
                    if (forkNode.setInfo.ConfluenceNo == null)
                    {
                        forkNode.setInfo.ConfluenceNo = 1;
                    }
                    else if (forkNode.setInfo.ConfluenceNo == (forkNumber - 1))
                    {
                        res = TagState.No.ToString("D");
                    }
                    else
                    {
                        bool isFirst = true; //是不是从会签开始到现在第一个
                        var preNode = GetPreNode(canCheckId);
                        while (preNode.id != forkNode.id) //反向一直到会签开始节点
                        {
                            if (preNode.setInfo != null && preNode.setInfo.Taged == (int)TagState.No)
                            {
                                isFirst = false;
                                break;
                            }
                        }

                        if (isFirst)
                        {
                            forkNode.setInfo.ConfluenceNo++;
                        }
                    }
                }
            }
            else //默认所有步骤通过
            {
                if (tag.Taged == (int)TagState.No) //只要有一个不同意，那么流程就结束
                {
                    res = TagState.No.ToString("D");
                }
                else if (tag.Taged == (int)TagState.Ok)
                {
                    if (nextNode.type == FlowNode.JOIN) //这种模式下只有坚持到【会签结束】节点之前才有意义，是否需要判定这条线所有的节点都通过，不然直接执行这个节点？？
                    {
                        if (forkNode.setInfo.ConfluenceOk == null)
                        {
                            forkNode.setInfo.ConfluenceOk = 1;
                        }
                        else if (forkNode.setInfo.ConfluenceOk == (forkNumber - 1)) //会签成功
                        {
                            res = GetNextNodeId(nextNode.id);
                        }
                        else
                        {
                            forkNode.setInfo.ConfluenceOk++;
                        }
                    }
                }
            }

            if (res == TagState.No.ToString("D"))
            {
                tag.Taged = (int)TagState.No;
                MakeTagNode(nextNode.id, tag);
            }
            else if (!string.IsNullOrEmpty(res)) //会签结束，标记合流节点
            {
                tag.Taged = (int)TagState.Ok;
                MakeTagNode(nextNode.id, tag);
                nextNodeId = res;
                nextNodeType = GetNodeType(res);
            }
            else
            {
                nextNodeId = nextNode.id;
                nextNodeType = GetNodeType(nextNode.id);
            }

            if (!string.IsNullOrEmpty(res)) //会签结束节点配置了回调，则发起通知
            {
                NotifyThirdParty(httpClient, nextNode, tag);
            }

            return res;
        }

        //获取上一个节点
        private FlowNode GetPreNode(string nodeId = null)
        {
            var lines = nodeId == null ? ToNodeLines[currentNodeId] : ToNodeLines[nodeId];
            if (lines.Count == 0)
            {
                throw new Exception("无法找到上一个点");
            }

            return Nodes[lines[0].from];
        }

        /// <summary>
        /// 驳回
        /// </summary>
        /// <param name="rejectType">驳回类型。null:使用节点配置的驳回类型/0:前一步/1:第一步/2：指定节点，使用NodeRejectStep</param>
        /// <returns></returns>
        public string RejectNode(string rejectType)
        {
            dynamic node = Nodes[currentNodeId];
            if (node.setInfo != null && string.IsNullOrEmpty(rejectType))
            {
                rejectType = node.setInfo.NodeRejectType;
            }

            if (rejectType == "0")
            {
                return previousId;
            }

            if (rejectType == "1")
            {
                return GetNextNodeId(startNodeId);
            }

            return previousId;
        }

        /// <summary>
        /// 撤销流程，清空所有节点
        /// </summary>
        public void ReCall()
        {
            foreach (var item in Nodes)
            {
                item.Value.setInfo = null;
            }
        }

        ///<summary>
        /// 标记节点1通过，-1不通过，0驳回
        /// </summary>
        /// <param name="nodeId"></param>
        public void MakeTagNode(string nodeId, Tag tag)
        {
            foreach (var item in Nodes)
            {
                if (item.Key == nodeId)
                {
                    if (item.Value.setInfo == null)
                    {
                        item.Value.setInfo = new Setinfo();
                    }

                    item.Value.setInfo.Taged = tag.Taged;
                    item.Value.setInfo.UserId = tag.UserId;
                    item.Value.setInfo.UserName = tag.UserName;
                    item.Value.setInfo.Description = tag.Description;
                    item.Value.setInfo.TagedTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
                    break;
                }
            }
        }

        public object ToSchemeObj()
        {
            return new
            {
                title = this.title,
                initNum = this.initNum,
                lines = Lines,
                nodes = Nodes.Select(u => u.Value),
                areas = new string[0]
            };
        }

        public void SaveOperationHis(string userId, string userName, string opHis)
        {
            FlowInstanceOperationHistory flowInstanceOperationHistory = new FlowInstanceOperationHistory
            {
                InstanceId = flowInstanceId,
                CreateUserId = userId,
                CreateUserName = userName,
                CreateDate = DateTime.Now,
                Content = opHis
            }; //操作记录

            var SugarClient = AutofacContainerModule.GetService<ISqlSugarClient>();
            SugarClient.Insertable(flowInstanceOperationHistory).ExecuteCommand();
        }

        /// <summary>
        /// 添加工作流实例操作记录
        /// <para>操作人为当前的登录用户</para>
        /// </summary>
        /// <param name="opHis"></param>
        public void SaveOperationHis(string opHis)
        {
            var user = AutofacContainerModule.GetService<IAuth>().GetCurrentUser().User;
            SaveOperationHis(user.Id, user.Name, opHis);
        }

        /// <summary>
        /// 保存本次扭转记录
        /// </summary>
        /// <returns></returns>
        public void SaveTransitionHis()
        {
            var user = AutofacContainerModule.GetService<IAuth>().GetCurrentUser().User;
            var SugarClient = AutofacContainerModule.GetService<ISqlSugarClient>();
            var transitionHistory = new FlowInstanceTransitionHistory
            {
                InstanceId = flowInstanceId,
                CreateUserId = user.Id,
                CreateUserName = user.Name,
                FromNodeId = currentNodeId,
                FromNodeName = currentNode.name,
                FromNodeType = currentNodeType,
                ToNodeId = nextNodeId,
                ToNodeName = nextNode?.name,
                ToNodeType = nextNodeType,
                IsFinish = nextNodeType == 4 ? FlowInstanceStatus.Finished : FlowInstanceStatus.Running,
                TransitionSate = 0
            };

            SugarClient.Insertable(transitionHistory).ExecuteCommand();
        }

        /// <summary>
        /// 通知三方系统，节点执行情况
        /// </summary>
        public void NotifyThirdParty(HttpClient client, FlowNode node, Tag tag)
        {
            if (node.setInfo == null || string.IsNullOrEmpty(node.setInfo.ThirdPartyUrl))
            {
                return;
            }

            var postData = new
            {
                flowInstanceId,
                nodeName = node.name,
                nodeId = node.id,
                userId = tag.UserId,
                userName = tag.UserName,
                result = tag.Taged, //1：通过;2：不通过；3驳回
                description = tag.Description,
                execTime = tag.TagedTime,
                isFinish = node.type == FlowNode.END
            };

            using (HttpContent httpContent = new StringContent(JsonHelper.Instance.Serialize(postData), Encoding.UTF8))
            {
                httpContent.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                client.PostAsync(node.setInfo.ThirdPartyUrl, httpContent);
            }
        }

        #endregion 共有方法

        #region 获取节点审批人

        /// <summary>
        /// 寻找下一步的执行人
        /// 一般用于本节点审核完成后，修改流程实例的当前执行人，可以做到通知等功能
        /// </summary>
        /// <returns></returns>
        public string GetNextMakers(NodeDesignateReq request = null)
        {
            string makerList = "";
            if (nextNodeId == "-1")
            {
                throw new Exception("无法寻找到下一个节点");
            }

            if (nextNodeType == 0) //如果是会签节点
            {
                makerList = GetForkNodeMakers(nextNodeId);
            }
            else if (nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_ROLE)
            {
                //如果是运行时指定角色
                if (nextNode.setInfo.NodeDesignate != request.NodeDesignateType)
                {
                    throw new Exception("前端提交的节点权限类型异常，请检查流程");
                }

                var revelanceApp = AutofacContainerModule.GetService<RevelanceManagerApp>();
                var users = revelanceApp.Get(Define.USERROLE, false, request.NodeDesignates);
                makerList = GenericHelpers.ArrayToString(users, makerList);
            }
            else if (nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_USER)
            {
                //如果是运行时指定用户
                if (nextNode.setInfo.NodeDesignate != request.NodeDesignateType)
                {
                    throw new Exception("前端提交的节点权限类型异常，请检查流程");
                }

                makerList = GenericHelpers.ArrayToString(request.NodeDesignates, makerList);
            }
            else if (nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_PARENT
                     || nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_MANY_PARENTS)
            {
                //如果是上一节点执行人的直属上级或连续多级直属上级
                if (nextNode.setInfo.NodeDesignate != request.NodeDesignateType)
                {
                    throw new Exception("前端提交的节点权限类型异常，请检查流程");
                }

                //当创建流程时，肯定执行的开始节点，登录用户就是创建用户
                //当审批流程时，能进到这里，表明当前登录用户已经有审批当前节点的权限，完全可以直接用登录用户的直接上级
                var userManagerApp = AutofacContainerModule.GetService<UserManagerApp>();
                var user = AutofacContainerModule.GetService<IAuth>().GetCurrentUser().User;
                var parentId = userManagerApp.GetParent(user.Id);
                if (StringExtension.IsNullOrEmpty(parentId))
                {
                    throw new Exception("无法找到当前用户的直属上级");
                }

                makerList = GenericHelpers.ArrayToString(new[] { parentId }, makerList);
            }
            else if (nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_CHAIRMAN)
            {
                //如果是发起人的部门负责人
                if (nextNode.setInfo.NodeDesignate != request.NodeDesignateType)
                {
                    throw new Exception("前端提交的节点权限类型异常，请检查流程");
                }

                var orgManagerApp = AutofacContainerModule.GetService<OrgManagerApp>();
                var chairmanIds = orgManagerApp.GetChairmanId(nextNode.setInfo.NodeDesignateData.orgs);
                makerList = GenericHelpers.ArrayToString(chairmanIds, makerList);
            }
            else
            {
                makerList = GetNodeMarkers(nextNode);
                if (string.IsNullOrEmpty(makerList))
                {
                    throw new Exception("无法寻找到节点的审核者,请查看流程设计是否有问题!");
                }
            }

            return makerList;
        }

        /// <summary>
        /// 计算节点执行人
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        public string GetNodeMarkers(FlowNode node, string flowinstanceCreateUserId = "")
        {
            string makerList = "";
            if (node.type == FlowNode.START && (!string.IsNullOrEmpty(flowinstanceCreateUserId))) //如果是开始节点，通常情况下是驳回到开始了
            {
                makerList = flowinstanceCreateUserId;
            }
            else if (node.setInfo != null)
            {
                if (string.IsNullOrEmpty(node.setInfo.NodeDesignate) ||
                    node.setInfo.NodeDesignate == Setinfo.ALL_USER) //所有成员
                {
                    makerList = "1";
                }
                else if (node.setInfo.NodeDesignate == Setinfo.SPECIAL_USER) //指定成员
                {
                    makerList = GenericHelpers.ArrayToString(node.setInfo.NodeDesignateData.users, makerList);
                }
                else if (node.setInfo.NodeDesignate == Setinfo.SPECIAL_ROLE) //指定角色
                {
                    var revelanceApp = AutofacContainerModule.GetService<RevelanceManagerApp>();
                    var users = revelanceApp.Get(Define.USERROLE, false, node.setInfo.NodeDesignateData.roles);
                    makerList = GenericHelpers.ArrayToString(users, makerList);
                }
                else if (node.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_ROLE
                         || node.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_USER)
                {
                    //如果是运行时选定的用户，则暂不处理。由上个节点审批时选定
                }
            }
            else //如果没有设置节点信息，默认所有人都可以审核
            {
                makerList = "1";
            }

            return makerList;
        }

        /// <summary>
        /// 会签时，获取一条会签分支上面是否有用户可审核的节点
        /// </summary>
        /// <param name="fromForkStartNode"></param>
        /// <param name="tag"></param>
        /// <returns></returns>
        public string GetOneForkLineCanCheckNodeId(FlowNode fromForkStartNode, Tag tag)
        {
            string canCheckId = "";
            var node = fromForkStartNode;
            do //沿一条分支线路执行，直到遇到会签结束节点
            {
                var makerList = GetNodeMarkers(node);

                if (node.setInfo.Taged == null && !string.IsNullOrEmpty(makerList) &&
                    makerList.Split(',').Any(one => tag.UserId == one))
                {
                    canCheckId = node.id;
                    break;
                }

                node = GetNextNode(node.id);
            } while (node.type != FlowNode.JOIN);

            return canCheckId;
        }

        /// <summary>
        /// 获取会签开始节点的所有可执行者
        /// </summary>
        /// <param name="forkNodeId">会签开始节点</param>
        /// <returns></returns>
        public string GetForkNodeMakers(string forkNodeId)
        {
            string makerList = "";
            foreach (string fromForkStartNodeId in FromNodeLines[forkNodeId].Select(u => u.to))
            {
                var fromForkStartNode = Nodes[fromForkStartNodeId]; //与会签开始节点直接连接的节点
                if (makerList != "")
                {
                    makerList += ",";
                }

                makerList += GetOneForkLineMakers(fromForkStartNode);
            }

            return makerList;
        }

        /// <summary>
        /// 获取会签一条线上的审核者,该审核者应该是已审核过的节点的下一个人
        /// </summary>
        /// <param name="fromForkStartNode">与会签开始节点直接连接的节点</param>
        private string GetOneForkLineMakers(FlowNode fromForkStartNode)
        {
            string markers = "";
            var node = fromForkStartNode;
            do //沿一条分支线路执行，直到遇到第一个没有审核的节点
            {
                if (node.setInfo != null && node.setInfo.Taged != null)
                {
                    if (node.type != FlowNode.FORK && node.setInfo.Taged != (int)TagState.Ok) //如果节点是不同意或驳回，则不用再找了
                    {
                        break;
                    }

                    node = GetNextNode(node.id); //下一个节点
                    continue;
                }

                var marker = GetNodeMarkers(node);
                if (marker == "")
                {
                    throw new Exception($"节点{node.name}没有审核者,请检查!");
                }

                if (marker == "1")
                {
                    throw new Exception($"节点{node.name}是会签节点，不能用所有人,请检查!");
                }

                if (markers != "")
                {
                    markers += ",";
                }

                markers += marker;
                break;
            } while (node.type != FlowNode.JOIN);

            return markers;
        }

        #endregion

        #region 属性

        private string title { get; set; }

        private int initNum { get; set; }

        /// <summary>
        /// 运行实例的Id
        /// </summary>
        private string flowInstanceId { get; set; }

        /// <summary>
        /// 上一个节点
        /// </summary>
        private string previousId { get; set; }

        /// <summary>
        /// 流程实例中所有的线段
        /// </summary>
        private List<FlowLine> Lines { get; set; }

        /// <summary>
        /// 从节点发出的线段集合
        /// </summary>
        private Dictionary<string, List<FlowLine>> FromNodeLines { get; set; }

        /// <summary>
        /// 到达节点的线段集合
        /// </summary>
        private Dictionary<string, List<FlowLine>> ToNodeLines { get; set; }

        /// <summary>
        /// 当前节点类型 0会签开始,1会签结束,2一般节点,开始节点,4流程运行结束
        /// </summary>
        private int currentNodeType { get; set; }

        /// <summary>
        /// 表单数据
        /// </summary>
        private string FrmData { get; set; }

        /// <summary>
        /// 开始节点的ID
        /// </summary>
        public string startNodeId { get; set; }

        /// <summary>
        /// 当前节点的ID
        /// </summary>
        public string currentNodeId { get; set; }

        /// <summary>
        /// 当前节点的对象
        /// </summary>
        public FlowNode currentNode => Nodes[currentNodeId];

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
        public FlowNode nextNode => nextNodeId != "-1" ? Nodes[nextNodeId] : null;

        /// <summary>
        /// 实例节点集合
        /// </summary>
        public Dictionary<string, FlowNode> Nodes { get; set; }

        #endregion 属性
    }
}