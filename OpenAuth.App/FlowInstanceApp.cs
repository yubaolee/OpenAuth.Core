using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using Newtonsoft.Json.Linq;
using OpenAuth.App.Flow;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    /// <summary>
    /// 工作流实例表操作
    /// </summary>
    public class FlowInstanceApp : BaseApp<FlowInstance>
    {
        
        #region 流程处理API
        /// <summary>
        /// 创建一个实例
        /// </summary>
        /// <returns></returns>
        public bool CreateInstance(JObject obj)
        {
            var flowInstance = obj.ToObject<FlowInstance>();

            //获取提交的表单数据
            var frmdata = new JObject();
            foreach (var property in obj.Properties().Where(U => U.Name.Contains("data_")))
            {
                frmdata[property.Name] = property.Value;
            }
            flowInstance.FrmData = JsonHelper.Instance.Serialize(frmdata);

            //创建运行实例
            var wfruntime = new FlowRuntime(flowInstance);
            var user = AuthUtil.GetCurrentUser();

            #region 根据运行实例改变当前节点状态
            flowInstance.ActivityId = wfruntime.runtimeModel.nextNodeId;
            flowInstance.ActivityType = wfruntime.GetNextNodeType();//-1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束
            flowInstance.ActivityName = wfruntime.runtimeModel.nextNode.name;
            flowInstance.PreviousId = wfruntime.runtimeModel.currentNodeId;
            flowInstance.CreateUserId = user.User.Id;
            flowInstance.CreateUserName = user.User.Account;
            flowInstance.MakerList = (wfruntime.GetNextNodeType() != 4 ? GetMakerList(wfruntime) : "");//当前节点可执行的人信息
            flowInstance.IsFinish = (wfruntime.GetNextNodeType() == 4 ? 1 : 0);
            #endregion

            #region 流程操作记录
            FlowInstanceOperationHistory processOperationHistoryEntity = new FlowInstanceOperationHistory
            {
                InstanceId = flowInstance.Id,
                Content = "【创建】"
                          + user.User.Name
                          + "创建了一个流程进程【"
                          + flowInstance.Code + "/"
                          + flowInstance.CustomName + "】"
            };

            #endregion

            #region 流转记录

            FlowInstanceTransitionHistory processTransitionHistoryEntity = new FlowInstanceTransitionHistory
            {
                InstanceId = flowInstance.Id,
                FromNodeId = wfruntime.runtimeModel.currentNodeId,
                FromNodeName = wfruntime.runtimeModel.currentNode.name,
                FromNodeType = wfruntime.runtimeModel.currentNodeType,
                ToNodeId = wfruntime.runtimeModel.nextNodeId,
                ToNodeName = wfruntime.runtimeModel.nextNode.name,
                ToNodeType = wfruntime.runtimeModel.nextNodeType,
                TransitionSate = 0
            };
            processTransitionHistoryEntity.IsFinish = (processTransitionHistoryEntity.ToNodeType == 4 ? 1 : 0);
            #endregion

            UnitWork.Add(flowInstance);
            UnitWork.Add(processOperationHistoryEntity);
            UnitWork.Add(processTransitionHistoryEntity);
            UnitWork.Save();
            return true;
        }

        /// <summary>
        /// 节点审核
        /// </summary>
        /// <param name="instanceId"></param>
        /// <returns></returns>
        public bool NodeVerification(string instanceId, bool flag, string description = "")
        {
            FlowInstance flowInstance = Get(instanceId);
            FlowInstanceOperationHistory flowInstanceOperationHistory = new FlowInstanceOperationHistory();//操作记录
            FlowInstanceTransitionHistory processTransitionHistoryEntity = null;//流转记录

            FlowRuntime wfruntime = new FlowRuntime(flowInstance);

            var user = AuthUtil.GetCurrentUser().User;
            var tag = new Tag
            {
                UserName = user.Name,
                UserId = user.Id,
                Description = description
            };
            #region 会签
            if (flowInstance.ActivityType == 0)//会签
            {
                tag.Taged = 1;
                wfruntime.MakeTagNode(wfruntime.runtimeModel.currentNodeId, tag);//标记当前节点通过
                ///寻找需要审核的节点Id
                string _VerificationNodeId = "";
                List<string> _nodelist = wfruntime.GetCountersigningNodeIdList(wfruntime.runtimeModel.currentNodeId);
                string _makerList = "";
                foreach (string item in _nodelist)
                {
                    _makerList = GetMakerList(wfruntime.runtimeModel.nodes[item], wfruntime.runtimeModel.flowInstanceId);
                    if (_makerList != "-1")
                    {
                        var id = AuthUtil.GetCurrentUser().User.Id;
                        foreach (string one in _makerList.Split(','))
                        {
                            if (id == one || id.IndexOf(one) != -1)
                            {
                                _VerificationNodeId = item;
                                break;
                            }
                        }
                    }
                }

                if (_VerificationNodeId != "")
                {
                    if (flag)
                    {
                        tag.Taged = 1;
                        flowInstanceOperationHistory.Content = "【" + "todo name" + "】【" + wfruntime.runtimeModel.nodes[_VerificationNodeId].name + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】同意,备注：" + description;
                    }
                    else
                    {
                        tag.Taged = -1;
                        flowInstanceOperationHistory.Content = "【" + "todo name" + "】【" + wfruntime.runtimeModel.nodes[_VerificationNodeId].name + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】不同意,备注：" + description;
                    }


                    string confluenceres = wfruntime.NodeConfluence(_VerificationNodeId, tag);
                    
                    switch (confluenceres)
                    {
                        case "-1"://不通过
                            flowInstance.IsFinish = 3;
                            break;
                        case "1"://等待
                            break;
                        default://通过
                            flowInstance.PreviousId = flowInstance.ActivityId;
                            flowInstance.ActivityId = wfruntime.runtimeModel.nextNodeId;
                            flowInstance.ActivityType = wfruntime.runtimeModel.nextNodeType;//-1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束
                            flowInstance.ActivityName = wfruntime.runtimeModel.nextNode.name;
                            flowInstance.IsFinish = (wfruntime.runtimeModel.nextNodeType == 4 ? 1 : 0);
                            flowInstance.MakerList = (wfruntime.runtimeModel.nextNodeType == 4 ? "" : GetMakerList(wfruntime));//当前节点可执行的人信息

                            #region 流转记录

                            processTransitionHistoryEntity = new FlowInstanceTransitionHistory
                            {
                                FromNodeId = wfruntime.runtimeModel.currentNodeId,
                                FromNodeName = wfruntime.runtimeModel.currentNode.name,
                                FromNodeType = wfruntime.runtimeModel.currentNodeType,
                                ToNodeId = wfruntime.runtimeModel.nextNodeId,
                                ToNodeName = wfruntime.runtimeModel.nextNode.name,
                                ToNodeType = wfruntime.runtimeModel.nextNodeType,
                                TransitionSate = 0
                            };
                            processTransitionHistoryEntity.IsFinish = (processTransitionHistoryEntity.ToNodeType == 4 ? 1 : 0);
                            #endregion
                                
                            break;
                    }
                }
                else
                {
                    throw (new Exception("审核异常,找不到审核节点"));
                }
            }
            #endregion

            #region 一般审核
            else//一般审核
            {
                if (flag)
                {
                    tag.Taged = 1;
                    wfruntime.MakeTagNode(wfruntime.runtimeModel.currentNodeId, tag);
                    flowInstance.PreviousId = flowInstance.ActivityId;
                    flowInstance.ActivityId = wfruntime.runtimeModel.nextNodeId;
                    flowInstance.ActivityType = wfruntime.runtimeModel.nextNodeType;
                    flowInstance.ActivityName = wfruntime.runtimeModel.nextNode.name;
                    flowInstance.MakerList = wfruntime.runtimeModel.nextNodeType == 4 ? "" : GetMakerList(wfruntime);//当前节点可执行的人信息
                    flowInstance.IsFinish = (wfruntime.runtimeModel.nextNodeType == 4 ? 1 : 0);
                    #region 流转记录

                    processTransitionHistoryEntity = new FlowInstanceTransitionHistory
                    {
                        FromNodeId = wfruntime.runtimeModel.currentNodeId,
                        FromNodeName = wfruntime.runtimeModel.currentNode.name,
                        FromNodeType = wfruntime.runtimeModel.currentNodeType,
                        ToNodeId = wfruntime.runtimeModel.nextNodeId,
                        ToNodeName = wfruntime.runtimeModel.nextNode.name,
                        ToNodeType = wfruntime.runtimeModel.nextNodeType,
                        TransitionSate = 0
                    };
                    processTransitionHistoryEntity.IsFinish = (processTransitionHistoryEntity.ToNodeType == 4 ? 1 : 0);
                    #endregion

                        
                    flowInstanceOperationHistory.Content = "【" + "todo name" + "】【" + wfruntime.runtimeModel.currentNode.name + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】同意,备注：" + description;
                }
                else
                {
                    flowInstance.IsFinish = 3; //表示该节点不同意
                    tag.Taged = -1;
                    wfruntime.MakeTagNode(wfruntime.runtimeModel.currentNodeId,tag);

                    flowInstanceOperationHistory.Content = "【" + "todo name" + "】【" + wfruntime.runtimeModel.currentNode.name + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】不同意,备注：" + description;
                }
            }
            #endregion

            flowInstance.SchemeContent = JsonHelper.Instance.Serialize(wfruntime.runtimeModel.schemeContentJson);

            UnitWork.Update(flowInstance);
            UnitWork.Add(flowInstanceOperationHistory);
            UnitWork.Add(processTransitionHistoryEntity);
            UnitWork.Save();
            return true;
        }
        /// <summary>
        /// 驳回
        /// </summary>
        /// <param name="processId"></param>
        /// <param name="nodeId"></param>
        /// <param name="description"></param>
        /// <returns></returns>
        public bool NodeReject(string processId, string nodeId, string description = "")
        {
            FlowInstance flowInstance = Get(processId);
            FlowInstanceOperationHistory flowInstanceOperationHistory = new FlowInstanceOperationHistory();
            FlowInstanceTransitionHistory processTransitionHistoryEntity = null;

            FlowRuntime wfruntime = new FlowRuntime(flowInstance);


            string resnode = "";
            if (nodeId == "")
            {
                resnode = wfruntime.RejectNode();
            }
            else
            {
                resnode = nodeId;
            }

            var user = AuthUtil.GetCurrentUser().User;
            var tag = new Tag
            {
                Description = description,
                Taged = 0,
                UserId = user.Id,
                UserName = user.Name
            };

            wfruntime.MakeTagNode(wfruntime.runtimeModel.currentNodeId, tag);
            flowInstance.IsFinish = 4;//4表示驳回（需要申请者重新提交表单）
            if (resnode != "")
            {
                flowInstance.PreviousId = flowInstance.ActivityId;
                flowInstance.ActivityId = resnode;
                flowInstance.ActivityType = wfruntime.GetNodeType(resnode);//-1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束
                flowInstance.ActivityName = wfruntime.runtimeModel.nodes[resnode].name;
                flowInstance.MakerList = GetMakerList(wfruntime.runtimeModel.nodes[resnode], flowInstance.PreviousId);//当前节点可执行的人信息
                #region 流转记录
                processTransitionHistoryEntity = new FlowInstanceTransitionHistory();
                processTransitionHistoryEntity.FromNodeId = wfruntime.runtimeModel.currentNodeId;
                processTransitionHistoryEntity.FromNodeName = wfruntime.runtimeModel.currentNode.name;
                processTransitionHistoryEntity.FromNodeType = wfruntime.runtimeModel.currentNodeType;
                processTransitionHistoryEntity.ToNodeId = wfruntime.runtimeModel.nextNodeId;
                processTransitionHistoryEntity.ToNodeName = wfruntime.runtimeModel.nextNode.name;
                processTransitionHistoryEntity.ToNodeType = wfruntime.runtimeModel.nextNodeType;
                processTransitionHistoryEntity.TransitionSate = 1;//
                processTransitionHistoryEntity.IsFinish = (processTransitionHistoryEntity.ToNodeType == 4 ? 1 : 0);
                #endregion
            }
            var data = new
            {
                SchemeContent = wfruntime.runtimeModel.schemeContentJson.ToString(),
                frmData = (flowInstance.FrmType == 0 ? wfruntime.runtimeModel.frmData : null)
            };
            flowInstanceOperationHistory.Content = "【" + "todo name" + "】【" + wfruntime.runtimeModel.currentNode.name + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】驳回,备注：" + description;

            UnitWork.Add(flowInstance);
            UnitWork.Add(flowInstanceOperationHistory);
            UnitWork.Add(processTransitionHistoryEntity);
            UnitWork.Save();

            return true;
        }
        #endregion

        /// <summary>
        /// 寻找该节点执行人
        /// </summary>
        /// <param name="wfruntime"></param>
        /// <returns></returns>
        private string GetMakerList(FlowRuntime wfruntime)
        {
            string makerList = "";
            if (wfruntime.runtimeModel.nextNodeId == "-1")
            {
                throw (new Exception("无法寻找到下一个节点"));
            }
            if (wfruntime.runtimeModel.nextNodeType == 0)//如果是会签节点
            {
                List<string> _nodelist = wfruntime.GetCountersigningNodeIdList(wfruntime.runtimeModel.nextNodeId);
                string _makerList = "";
                foreach (string item in _nodelist)
                {
                    _makerList = GetMakerList(wfruntime.runtimeModel.nodes[item], wfruntime.runtimeModel.flowInstanceId);
                    if (_makerList == "-1")
                    {
                        throw (new Exception("无法寻找到会签节点的审核者,请查看流程设计是否有问题!"));
                    }
                    if (_makerList == "1")
                    {
                        throw (new Exception("会签节点的审核者不能为所有人,请查看流程设计是否有问题!"));
                    }
                    if (makerList != "")
                    {
                        makerList += ",";
                    }
                    makerList += _makerList;
                }
            }
            else
            {
                makerList = GetMakerList(wfruntime.runtimeModel.nextNode, wfruntime.runtimeModel.flowInstanceId);
                if (makerList == "-1")
                {
                    throw (new Exception("无法寻找到节点的审核者,请查看流程设计是否有问题!"));
                }
            }

            return makerList;
        }
        /// <summary>
        /// 寻找该节点执行人
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        private string GetMakerList(FlowNode node, string processId)
        {
            try
            {
                string makerlsit = "";

                if (node.setInfo == null)
                {
                    makerlsit = "-1";
                }
                else
                {
                    //if (node.setInfo.NodeDesignate.Value == "NodeDesignateType1")//所有成员
                    //{
                    //    makerlsit = "1";
                    //}
                    //else if (node.setInfo.NodeDesignate.Value == "NodeDesignateType2")//指定成员
                    //{
                    makerlsit = GenericHelpers.ArrayToString(node.setInfo.NodeDesignateData.role, makerlsit);
                    // makerlsit = ArrwyToString(node.setInfo.NodeDesignateData.post, makerlsit);
                    //   makerlsit = ArrwyToString(node.setInfo.NodeDesignateData.usergroup, makerlsit);
                    makerlsit = GenericHelpers.ArrayToString(node.setInfo.NodeDesignateData.users, makerlsit);

                    if (makerlsit == "")
                    {
                        makerlsit = "-1";
                    }
                    // }
                    //else if (node.setInfo.NodeDesignate.Value == "NodeDesignateType3")//发起者领导
                    //{
                    //    UserEntity userEntity = userService.GetEntity(OperatorProvider.Provider.Current().UserId);
                    //    if (string.IsNullOrEmpty(userEntity.ManagerId))
                    //    {
                    //        makerlsit = "-1";
                    //    }
                    //    else
                    //    {
                    //        makerlsit = userEntity.ManagerId;
                    //    }
                    //}
                    //else if (node.setInfo.NodeDesignate.Value == "NodeDesignateType4")//前一步骤领导
                    //{
                    //    FlowInstanceTransitionHistory transitionHistoryEntity = FlowInstanceTransitionHistoryService.GetEntity(flowInstanceId, node.id.Value);
                    //    UserEntity userEntity = userService.GetEntity(transitionHistoryEntity.CreateUserId);
                    //    if (string.IsNullOrEmpty(userEntity.ManagerId))
                    //    {
                    //        makerlsit = "-1";
                    //    }
                    //    else
                    //    {
                    //        makerlsit = userEntity.ManagerId;
                    //    }
                    //}
                    //else if (node.setInfo.NodeDesignate.Value == "NodeDesignateType5")//发起者部门领导
                    //{
                    //    UserEntity userEntity = userService.GetEntity(OperatorProvider.Provider.Current().UserId);
                    //    DepartmentEntity departmentEntity = departmentService.GetEntity(userEntity.DepartmentId);

                    //    if (string.IsNullOrEmpty(departmentEntity.ManagerId))
                    //    {
                    //        makerlsit = "-1";
                    //    }
                    //    else
                    //    {
                    //        makerlsit = departmentEntity.ManagerId;
                    //    }
                    //}
                    //else if (node.setInfo.NodeDesignate.Value == "NodeDesignateType6")//发起者公司领导
                    //{
                    //    UserEntity userEntity = userService.GetEntity(OperatorProvider.Provider.Current().UserId);
                    //    OrganizeEntity organizeEntity = organizeService.GetEntity(userEntity.OrganizeId);

                    //    if (string.IsNullOrEmpty(organizeEntity.ManagerId))
                    //    {
                    //        makerlsit = "-1";
                    //    }
                    //    else
                    //    {
                    //        makerlsit = organizeEntity.ManagerId;
                    //    }
                    //}
                }
                return makerlsit;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 将数组转化成逗号相隔的字串
        /// </summary>
        /// <param name="data"></param>
        /// <param name="Str"></param>
        /// <returns></returns>
       
        /// <summary>
        /// 审核流程
        /// <para>李玉宝于2017-01-20 15:44:45</para>
        /// </summary>
        public void Verification(VerificationReq request)
        {
            //驳回
            if (request.VerificationFinally == "3")
            {
                string _nodeId = "";
                if (!string.IsNullOrEmpty(request.NodeRejectStep))
                {
                    _nodeId = request.NodeRejectStep;
                }
                NodeReject(request.FlowInstanceId, _nodeId, request.VerificationOpinion);
            }
            else if (request.VerificationFinally == "2")//表示不同意
            {
                NodeVerification(request.FlowInstanceId, false, request.VerificationOpinion);
            }
            else if (request.VerificationFinally == "1")//表示同意
            {
                NodeVerification(request.FlowInstanceId, true, request.VerificationOpinion);
            }
        }

        public void Update(FlowInstance flowScheme)
        {
            Repository.Update(u => u.Id == flowScheme.Id, u => new FlowInstance());
        }

        public TableData Load(QueryFlowInstanceListReq request)
        {
            //todo:待办/已办/我的
            var result = new TableData();

            result.count = UnitWork.Find<FlowInstance>(u => u.CreateUserId == request.userid).Count();
            if (request.type == "inbox")   //待办事项
            {
                result.data = UnitWork.Find<FlowInstance>(request.page, request.limit, "CreateDate descending", null).ToList();

            }
            else if (request.type == "outbox")  //已办事项
            {
                result.data = UnitWork.Find<FlowInstance>(request.page, request.limit, "CreateDate descending", null).ToList();

            }
            else  //我的流程
            {
                result.data = UnitWork.Find<FlowInstance>(request.page, request.limit, "CreateDate descending", null).ToList();
            }

            return result;
        }
    }
}
