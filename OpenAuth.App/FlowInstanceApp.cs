using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Extention;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    /// <summary>
    /// 工作流实例表操作
    /// </summary>
    public class FlowInstanceApp :BaseApp<FlowInstance>
    {

        #region 获取数据
        /// <summary>
        /// 获取实例进程信息实体
        /// </summary>
        /// <param name="keyVlaue">The key vlaue.</param>
        /// <returns>FlowInstance.</returns>
        public FlowInstance GetEntity(string keyVlaue)
        {
            try
            {
                return UnitWork.FindSingle<FlowInstance>(u =>u.Id == keyVlaue);
            }
            catch
            {
                throw;
            }
        }
        #endregion

        #region 提交数据
        /// <summary>
        /// 存储工作流实例进程(编辑草稿用)
        /// </summary>
        /// <param name="flowInstance"></param>
        /// <param name="wfOperationHistoryEntity"></param>
        /// <returns></returns>
        public int SaveProcess(string processId, FlowInstance flowInstance, FlowInstanceOperationHistory wfOperationHistoryEntity = null)
        {
            try
            {
                if (string.Empty ==(flowInstance.Id))
                {
                    UnitWork.Add(flowInstance);

                }
                else
                {
                    flowInstance.Id = (processId);
                    UnitWork.Update(flowInstance);
                }
                if (wfOperationHistoryEntity != null)
                {
                    wfOperationHistoryEntity.InstanceId = processId;
                    UnitWork.Add(wfOperationHistoryEntity);
                }
                UnitWork.Save();
                return 1;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 存储工作流实例进程(创建实例进程)
        /// </summary>
        /// <param name="wfRuntimeModel"></param>
        /// <param name="flowInstance"></param>
        /// <param name="processOperationHistoryEntity"></param>
        /// <returns></returns>
        public int SaveProcess(WF_RuntimeModel wfRuntimeModel, FlowInstance flowInstance,  FlowInstanceOperationHistory processOperationHistoryEntity, FlowInstanceTransitionHistory processTransitionHistoryEntity)
        {
            try
            {
                if (string.Empty == (flowInstance.Id))
                {

                    flowInstance.Id = (string)(wfRuntimeModel.processId);
                    UnitWork.Add(flowInstance);
                }
                else
                {
                    flowInstance.Id =(flowInstance.Id);
                    UnitWork.Update(flowInstance);
                }
                processOperationHistoryEntity.InstanceId = flowInstance.Id;
                UnitWork.Add(processOperationHistoryEntity);

                if (processTransitionHistoryEntity != null)
                {
                    processTransitionHistoryEntity.InstanceId = flowInstance.Id;
                    UnitWork.Add(processTransitionHistoryEntity);
                }
              
                UnitWork.Save();
                return 1;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 存储工作流实例进程（审核驳回重新提交）
        /// </summary>
        /// <param name="processInstanceEntity"></param>
        /// <param name="processSchemeEntity"></param>
        /// <param name="processOperationHistoryEntity"></param>
        /// <param name="processTransitionHistoryEntity"></param>
        /// <returns></returns>
        public int SaveProcess(FlowInstance processInstanceEntity,  
            FlowInstanceOperationHistory processOperationHistoryEntity,  FlowInstanceTransitionHistory processTransitionHistoryEntity = null)
        {
            try
            {
                processInstanceEntity.Id=(processInstanceEntity.Id);
                UnitWork.Update(processInstanceEntity);

                processOperationHistoryEntity.InstanceId = processInstanceEntity.Id;
                UnitWork.Add(processOperationHistoryEntity);

                if (processTransitionHistoryEntity != null)
                {
                    processTransitionHistoryEntity.InstanceId = processInstanceEntity.Id;
                    UnitWork.Add(processTransitionHistoryEntity);
                }
               
                UnitWork.Save();
                return 1;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        ///  更新流程实例 审核节点用
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="dbbaseId"></param>
        /// <param name="processInstanceEntity"></param>
        /// <param name="processSchemeEntity"></param>
        /// <param name="processOperationHistoryEntity"></param>
        /// <param name="delegateRecordEntityList"></param>
        /// <param name="processTransitionHistoryEntity"></param>
        /// <returns></returns>
        public int SaveProcess(string sql,string dbbaseId, FlowInstance processInstanceEntity,  FlowInstanceOperationHistory processOperationHistoryEntity, FlowInstanceTransitionHistory processTransitionHistoryEntity = null)
        {
            try
            {
                processInstanceEntity.Id=(processInstanceEntity.Id);
                UnitWork.Update(processInstanceEntity);

                processOperationHistoryEntity.InstanceId = processInstanceEntity.Id;
                UnitWork.Add(processOperationHistoryEntity);

                if (processTransitionHistoryEntity != null)
                {
                    processTransitionHistoryEntity.InstanceId = processInstanceEntity.Id;
                    UnitWork.Add(processTransitionHistoryEntity);
                }
               
                //if (!string.IsNullOrEmpty(dbbaseId) && !string.IsNullOrEmpty(sql))//测试环境不允许执行sql语句
                //{
                //    DataBaseLinkEntity dataBaseLinkEntity = dataBaseLinkService.GetEntity(dbbaseId);//获取
                //    this.BaseRepository(dataBaseLinkEntity.DbConnection).ExecuteBySql(sql.Replace("{0}", processInstanceEntity.Id));
                //}
                UnitWork.Save();
                return 1;
            }
            catch
            {
                throw;
            }
        }

        #endregion

        
        #region 流程处理API
        /// <summary>
        /// 创建一个实例
        /// </summary>
        /// <param name="processId">进程GUID</param>
        /// <param name="schemeInfoId">模板信息ID</param>
        /// <param name="wfLevel"></param>
        /// <param name="code">进程编号</param>
        /// <param name="customName">自定义名称</param>
        /// <param name="description">备注</param>
        /// <param name="frmData">表单数据信息</param>
        /// <returns></returns>
        public bool CreateInstance(string processId, string schemeInfoId, FlowInstance FlowInstance, string frmData = null)
        {

            try
            {
                FlowScheme FlowScheme = UnitWork.FindSingle<FlowScheme>(u => u.Id == schemeInfoId);
               

                WF_RuntimeInitModel wfRuntimeInitModel = new WF_RuntimeInitModel()
                {
                    schemeContent = FlowScheme.SchemeContent,
                    currentNodeId = "",
                    frmData = frmData,
                    processId = processId
                };
                WF_Runtime wfruntime = null;

                if (frmData == null)
                {
                    throw new Exception("自定义表单需要提交表单数据");
                }
                else
                {
                    wfruntime = new WF_Runtime(wfRuntimeInitModel);
                }


                var user = AuthUtil.GetCurrentUser();
                #region 实例信息
                FlowInstance.ActivityId = wfruntime.runtimeModel.nextNodeId;
                FlowInstance.ActivityType = wfruntime.GetStatus();//-1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束
                FlowInstance.ActivityName = wfruntime.runtimeModel.nextNode.name;
                FlowInstance.PreviousId = wfruntime.runtimeModel.currentNodeId;
                FlowInstance.SchemeType = FlowScheme.SchemeType;
                FlowInstance.FrmType = FlowScheme.FrmType;
                FlowInstance.Disabled = 0;//正式运行
                FlowInstance.CreateUserId = user.User.Id.ToString();
                FlowInstance.CreateUserName = user.User.Account;
                FlowInstance.MakerList = (wfruntime.GetStatus() != 4 ? GetMakerList(wfruntime) : "");//当前节点可执行的人信息
                FlowInstance.IsFinish = (wfruntime.GetStatus() == 4 ? 1 : 0);
                FlowInstance.SchemeContent = FlowScheme.SchemeContent;
                #endregion

              

                #region 流程操作记录
                FlowInstanceOperationHistory processOperationHistoryEntity = new FlowInstanceOperationHistory();
                processOperationHistoryEntity.Content = "【创建】" + user.User.Name + "创建了一个流程进程【" + FlowInstance.Code + "/" + FlowInstance.CustomName + "】";
                #endregion

                #region 流转记录
                FlowInstanceTransitionHistory processTransitionHistoryEntity = new FlowInstanceTransitionHistory();
                processTransitionHistoryEntity.FromNodeId = wfruntime.runtimeModel.currentNodeId;
                processTransitionHistoryEntity.FromNodeName = wfruntime.runtimeModel.currentNode.name.Value;
                processTransitionHistoryEntity.FromNodeType = wfruntime.runtimeModel.currentNodeType;
                processTransitionHistoryEntity.ToNodeId = wfruntime.runtimeModel.nextNodeId;
                processTransitionHistoryEntity.ToNodeName = wfruntime.runtimeModel.nextNode.name.Value;
                processTransitionHistoryEntity.ToNodeType = wfruntime.runtimeModel.nextNodeType;
                processTransitionHistoryEntity.TransitionSate = 0;
                processTransitionHistoryEntity.IsFinish = (processTransitionHistoryEntity.ToNodeType == 4 ? 1 : 0);
                #endregion

                #region 委托记录
                //List<WFDelegateRecord> delegateRecordEntitylist = GetDelegateRecordList(schemeInfoId, FlowInstance.Code, FlowInstance.CustomName, FlowInstance.MakerList);
                //FlowInstance.MakerList += delegateUserList;
                #endregion

                SaveProcess(wfruntime.runtimeModel, FlowInstance, processOperationHistoryEntity, processTransitionHistoryEntity);

                return true;
            }
            catch
            {
                throw;
            }

        }

        /// <summary>
        /// 节点审核
        /// </summary>
        /// <param name="processId"></param>
        /// <returns></returns>
        public bool NodeVerification(string processId, bool flag, string description = "")
        {
            bool _res = false;
            try
            {
                string _sqlstr = "", _dbbaseId = "";
                FlowInstance FlowInstance = GetEntity(processId);
                FlowInstanceOperationHistory FlowInstanceOperationHistory = new FlowInstanceOperationHistory();//操作记录
                FlowInstanceTransitionHistory processTransitionHistoryEntity = null;//流转记录

                WF_RuntimeInitModel wfRuntimeInitModel = new WF_RuntimeInitModel()
                {
                    currentNodeId = FlowInstance.ActivityId,
                    previousId = FlowInstance.PreviousId,
                    processId = processId
                };
                WF_Runtime wfruntime = new WF_Runtime(wfRuntimeInitModel);


                #region 会签
                if (FlowInstance.ActivityType == 0)//会签
                {
                    wfruntime.MakeTagNode(wfruntime.runtimeModel.currentNodeId, 1, "");//标记当前节点通过
                    ///寻找需要审核的节点Id
                    string _VerificationNodeId = "";
                    List<string> _nodelist = wfruntime.GetCountersigningNodeIdList(wfruntime.runtimeModel.currentNodeId);
                    string _makerList = "";
                    foreach (string item in _nodelist)
                    {
                        _makerList = GetMakerList(wfruntime.runtimeModel.nodeDictionary[item], wfruntime.runtimeModel.processId);
                        if (_makerList != "-1")
                        {
                            var id = AuthUtil.GetCurrentUser().User.Id.ToString();
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
                            FlowInstanceOperationHistory.Content = "【" + "todo name" + "】【" + wfruntime.runtimeModel.nodeDictionary[_VerificationNodeId].name + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】同意,备注：" + description;
                        }
                        else
                        {
                            FlowInstanceOperationHistory.Content = "【" + "todo name" + "】【" + wfruntime.runtimeModel.nodeDictionary[_VerificationNodeId].name + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】不同意,备注：" + description;
                        }

                        string _Confluenceres = wfruntime.NodeConfluence(_VerificationNodeId, flag, AuthUtil.GetCurrentUser().User.Id.ToString(), description);
                        var _data = new
                        {
                            SchemeContent = wfruntime.runtimeModel.schemeContentJson.ToString(),
                            frmData = wfruntime.runtimeModel.frmData
                        };
                        switch (_Confluenceres)
                        {
                            case "-1"://不通过
                                FlowInstance.IsFinish = 3;
                                break;
                            case "1"://等待
                                break;
                            default://通过
                                FlowInstance.PreviousId = FlowInstance.ActivityId;
                                FlowInstance.ActivityId = wfruntime.runtimeModel.nextNodeId;
                                FlowInstance.ActivityType = wfruntime.runtimeModel.nextNodeType;//-1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束
                                FlowInstance.ActivityName = wfruntime.runtimeModel.nextNode.name;
                                FlowInstance.IsFinish = (wfruntime.runtimeModel.nextNodeType == 4 ? 1 : 0);
                                FlowInstance.MakerList = (wfruntime.runtimeModel.nextNodeType == 4 ?"": GetMakerList(wfruntime) );//当前节点可执行的人信息

                                #region 流转记录
                                processTransitionHistoryEntity = new FlowInstanceTransitionHistory();
                                processTransitionHistoryEntity.FromNodeId = wfruntime.runtimeModel.currentNodeId;
                                processTransitionHistoryEntity.FromNodeName = wfruntime.runtimeModel.currentNode.name.Value;
                                processTransitionHistoryEntity.FromNodeType = wfruntime.runtimeModel.currentNodeType;
                                processTransitionHistoryEntity.ToNodeId = wfruntime.runtimeModel.nextNodeId;
                                processTransitionHistoryEntity.ToNodeName = wfruntime.runtimeModel.nextNode.name.Value;
                                processTransitionHistoryEntity.ToNodeType = wfruntime.runtimeModel.nextNodeType;
                                processTransitionHistoryEntity.TransitionSate = 0;
                                processTransitionHistoryEntity.IsFinish = (processTransitionHistoryEntity.ToNodeType == 4 ? 1 : 0);
                                #endregion



                                if (wfruntime.runtimeModel.currentNode.setInfo != null && wfruntime.runtimeModel.currentNode.setInfo.NodeSQL != null)
                                {
                                    _sqlstr = wfruntime.runtimeModel.currentNode.setInfo.NodeSQL.Value;
                                    _dbbaseId = wfruntime.runtimeModel.currentNode.setInfo.NodeDataBaseToSQL.Value;
                                }
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
                        wfruntime.MakeTagNode(wfruntime.runtimeModel.currentNodeId, 1, AuthUtil.GetCurrentUser().User.Id.ToString(), description);
                        FlowInstance.PreviousId = FlowInstance.ActivityId;
                        FlowInstance.ActivityId = wfruntime.runtimeModel.nextNodeId;
                        FlowInstance.ActivityType = wfruntime.runtimeModel.nextNodeType;//-1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束
                        FlowInstance.ActivityName = wfruntime.runtimeModel.nextNode.name;
                        FlowInstance.MakerList = wfruntime.runtimeModel.nextNodeType == 4 ? "" : GetMakerList(wfruntime);//当前节点可执行的人信息
                        FlowInstance.IsFinish = (wfruntime.runtimeModel.nextNodeType == 4 ? 1 : 0);
                        #region 流转记录

                        processTransitionHistoryEntity = new FlowInstanceTransitionHistory
                        {
                            FromNodeId = wfruntime.runtimeModel.currentNodeId,
                            FromNodeName = wfruntime.runtimeModel.currentNode.name.Value,
                            FromNodeType = wfruntime.runtimeModel.currentNodeType,
                            ToNodeId = wfruntime.runtimeModel.nextNodeId,
                            ToNodeName = wfruntime.runtimeModel.nextNode.name.Value,
                            ToNodeType = wfruntime.runtimeModel.nextNodeType,
                            TransitionSate = 0
                        };
                        processTransitionHistoryEntity.IsFinish = (processTransitionHistoryEntity.ToNodeType == 4 ? 1 : 0);
                        #endregion



                        if (wfruntime.runtimeModel.currentNode.setInfo != null && wfruntime.runtimeModel.currentNode.setInfo.NodeSQL != null)
                        {
                            _sqlstr = wfruntime.runtimeModel.currentNode.setInfo.NodeSQL.Value;
                            _dbbaseId = wfruntime.runtimeModel.currentNode.setInfo.NodeDataBaseToSQL.Value;
                        }

                        FlowInstanceOperationHistory.Content = "【" + "todo name" + "】【" + wfruntime.runtimeModel.currentNode.name + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】同意,备注：" + description;
                    }
                    else
                    {
                        FlowInstance.IsFinish = 3; //表示该节点不同意
                        wfruntime.MakeTagNode(wfruntime.runtimeModel.currentNodeId, -1, AuthUtil.GetUserName(), description);

                        FlowInstanceOperationHistory.Content = "【" + "todo name" + "】【" + wfruntime.runtimeModel.currentNode.name + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】不同意,备注：" + description;
                    }
                    var data = new
                    {
                        SchemeContent = wfruntime.runtimeModel.schemeContentJson.ToString(),
                        frmData = wfruntime.runtimeModel.frmData 
                    };
                }
                #endregion 

                _res = true;
                SaveProcess(_sqlstr, _dbbaseId, FlowInstance, FlowInstanceOperationHistory, processTransitionHistoryEntity);
                return _res;
            }
            catch
            {
                throw;
            }
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
            try
            {
                FlowInstance FlowInstance = GetEntity(processId);
                FlowInstanceOperationHistory FlowInstanceOperationHistory = new FlowInstanceOperationHistory();
                FlowInstanceTransitionHistory processTransitionHistoryEntity = null;
                WF_RuntimeInitModel wfRuntimeInitModel = new WF_RuntimeInitModel()
                {
                    currentNodeId = FlowInstance.ActivityId,
                    previousId = FlowInstance.PreviousId,
                    processId = processId
                };
                WF_Runtime wfruntime = new WF_Runtime(wfRuntimeInitModel);


                string resnode = "";
                if (nodeId == "")
                {
                    resnode = wfruntime.RejectNode();
                }
                else
                {
                    resnode = nodeId;
                }
                wfruntime.MakeTagNode(wfruntime.runtimeModel.currentNodeId, 0, AuthUtil.GetUserName(), description);
                FlowInstance.IsFinish = 4;//4表示驳回（需要申请者重新提交表单）
                if (resnode != "")
                {
                    FlowInstance.PreviousId = FlowInstance.ActivityId;
                    FlowInstance.ActivityId = resnode;
                    FlowInstance.ActivityType = wfruntime.GetNodeStatus(resnode);//-1无法运行,0会签开始,1会签结束,2一般节点,4流程运行结束
                    FlowInstance.ActivityName = wfruntime.runtimeModel.nodeDictionary[resnode].name;
                    FlowInstance.MakerList = GetMakerList(wfruntime.runtimeModel.nodeDictionary[resnode], FlowInstance.PreviousId);//当前节点可执行的人信息
                    #region 流转记录
                    processTransitionHistoryEntity = new FlowInstanceTransitionHistory();
                    processTransitionHistoryEntity.FromNodeId = wfruntime.runtimeModel.currentNodeId;
                    processTransitionHistoryEntity.FromNodeName = wfruntime.runtimeModel.currentNode.name.Value;
                    processTransitionHistoryEntity.FromNodeType = wfruntime.runtimeModel.currentNodeType;
                    processTransitionHistoryEntity.ToNodeId = wfruntime.runtimeModel.nextNodeId;
                    processTransitionHistoryEntity.ToNodeName = wfruntime.runtimeModel.nextNode.name.Value;
                    processTransitionHistoryEntity.ToNodeType = wfruntime.runtimeModel.nextNodeType;
                    processTransitionHistoryEntity.TransitionSate = 1;//
                    processTransitionHistoryEntity.IsFinish = (processTransitionHistoryEntity.ToNodeType == 4 ? 1 : 0);
                    #endregion
                }
                var data = new
                {
                    SchemeContent = wfruntime.runtimeModel.schemeContentJson.ToString(),
                    frmData = (FlowInstance.FrmType == 0 ? wfruntime.runtimeModel.frmData : null)
                };
                FlowInstanceOperationHistory.Content = "【" + "todo name" + "】【" + wfruntime.runtimeModel.currentNode.name + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】驳回,备注：" + description;

                SaveProcess(FlowInstance, FlowInstanceOperationHistory, processTransitionHistoryEntity);
                return true;
            }
            catch
            {
                throw;
            }
        }
        #endregion

        /// <summary>
        /// 寻找该节点执行人
        /// </summary>
        /// <param name="wfruntime"></param>
        /// <returns></returns>
        private string GetMakerList(WF_Runtime wfruntime)
        {
            try
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
                        _makerList = GetMakerList(wfruntime.runtimeModel.nodeDictionary[item], wfruntime.runtimeModel.processId);
                        if (_makerList == "-1")
                        {
                            throw (new Exception("无法寻找到会签节点的审核者,请查看流程设计是否有问题!"));
                        }
                        else if (_makerList == "1")
                        {
                            throw (new Exception("会签节点的审核者不能为所有人,请查看流程设计是否有问题!"));
                        }
                        else
                        {
                            if (makerList != "")
                            {
                                makerList += ",";
                            }
                            makerList += _makerList;
                        }
                    }
                }
                else
                {
                    makerList = GetMakerList(wfruntime.runtimeModel.nextNode, wfruntime.runtimeModel.processId);
                    if (makerList == "-1")
                    {
                        throw (new Exception("无法寻找到节点的审核者,请查看流程设计是否有问题!"));
                    }
                }

                return makerList;
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// 寻找该节点执行人
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        private string GetMakerList(dynamic node, string processId)
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
                    if (node.setInfo.NodeDesignate.Value == "NodeDesignateType1")//所有成员
                    {
                        makerlsit = "1";
                    }
                    else if (node.setInfo.NodeDesignate.Value == "NodeDesignateType2")//指定成员
                    {
                        makerlsit = ArrwyToString(node.setInfo.NodeDesignateData.role, makerlsit);
                        makerlsit = ArrwyToString(node.setInfo.NodeDesignateData.post, makerlsit);
                        makerlsit = ArrwyToString(node.setInfo.NodeDesignateData.usergroup, makerlsit);
                        makerlsit = ArrwyToString(node.setInfo.NodeDesignateData.user, makerlsit);

                        if (makerlsit == "")
                        {
                            makerlsit = "-1";
                        }
                    }
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
                    //    FlowInstanceTransitionHistory transitionHistoryEntity = FlowInstanceTransitionHistoryService.GetEntity(processId, node.id.Value);
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
        private string ArrwyToString(dynamic data, string Str)
        {
            string resStr = Str;
            foreach (var item in data)
            {
                if (resStr != "")
                {
                    resStr += ",";
                }
                resStr += item.Value;
            }
            return resStr;
        }


        /// <summary>
        /// 审核流程
        /// <para>李玉宝于2017-01-20 15:44:45</para>
        /// </summary>
        /// <param name="processId">The process identifier.</param>
        /// <param name="verificationData">The verification data.</param>
        public void VerificationProcess(string processId, string verificationData)
        {
            try
            {
                dynamic verificationDataJson = verificationData.ToJson();

                //驳回
                if (verificationDataJson.VerificationFinally.Value == "3")
                {
                    string _nodeId = "";
                    if (verificationDataJson.NodeRejectStep != null)
                    {
                        _nodeId = verificationDataJson.NodeRejectStep.Value;
                    }
                    NodeReject(processId, _nodeId, verificationDataJson.VerificationOpinion.Value);
                }
                else if (verificationDataJson.VerificationFinally.Value == "2")//表示不同意
                {
                    NodeVerification(processId, false, verificationDataJson.VerificationOpinion.Value);
                }
                else if (verificationDataJson.VerificationFinally.Value == "1")//表示同意
                {
                    NodeVerification(processId, true, verificationDataJson.VerificationOpinion.Value);
                }
            }
            catch
            {
                throw;
            }
        }


        public void Add(FlowInstance instance)
        {
            Repository.Add(instance);
        }

        public void Update(FlowInstance flowScheme)
        {
           Repository.Update(u => u.Id == flowScheme.Id, u => new FlowInstance
            {
                //todo:要修改的
            });
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
