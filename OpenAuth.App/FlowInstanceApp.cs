// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : 李玉宝
// Created          : 07-19-2018
//
// Last Modified By : 李玉宝
// Last Modified On : 07-19-2018
// ***********************************************************************
// <copyright file="FlowInstanceApp.cs" company="OpenAuth.App">
//     Copyright (c) http://www.openauth.me. All rights reserved.
// </copyright>
// <summary></summary>
// ***********************************************************************

using Infrastructure;
using OpenAuth.App.Flow;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Net.Http;

namespace OpenAuth.App
{
    /// <summary>
    /// 工作流实例表操作
    /// </summary>
    public class FlowInstanceApp : BaseApp<FlowInstance>
    {
        private RevelanceManagerApp _revelanceApp;
        private FlowSchemeApp _flowSchemeApp;
        private FormApp _formApp;
        private IHttpClientFactory _httpClientFactory;
        private IServiceProvider _serviceProvider;

        #region 流程处理API

        /// <summary>
        /// 创建一个实例
        /// </summary>
        /// <returns></returns>
        public bool CreateInstance(AddFlowInstanceReq addFlowInstanceReq)
        {
            FlowScheme scheme = null;
            if (!string.IsNullOrEmpty(addFlowInstanceReq.SchemeId))
            {
                scheme = _flowSchemeApp.Get(addFlowInstanceReq.SchemeId);
            }

            if ((scheme == null) && !string.IsNullOrEmpty(addFlowInstanceReq.SchemeCode))
            {
                scheme = _flowSchemeApp.FindByCode(addFlowInstanceReq.SchemeCode);
            }

            if (scheme == null)
            {
                throw new Exception("该流程模板已不存在，请重新设计流程");
            }

            addFlowInstanceReq.SchemeContent = scheme.SchemeContent;

            var form = _formApp.FindSingle(scheme.FrmId);
            if (form == null)
            {
                throw new Exception("该流程模板对应的表单已不存在，请重新设计流程");
            }

            addFlowInstanceReq.FrmContentData = form.ContentData;
            addFlowInstanceReq.FrmContentParse = form.ContentParse;
            addFlowInstanceReq.FrmType = form.FrmType;
            addFlowInstanceReq.FrmId = form.Id;

            var flowInstance = addFlowInstanceReq.MapTo<FlowInstance>();

            //创建运行实例
            var wfruntime = new FlowRuntime(flowInstance);
            var user = _auth.GetCurrentUser();

            #region 根据运行实例改变当前节点状态

            flowInstance.ActivityId = wfruntime.nextNodeId;
            flowInstance.ActivityType = wfruntime.GetNextNodeType();
            flowInstance.ActivityName = wfruntime.nextNode.name;
            flowInstance.PreviousId = wfruntime.currentNodeId;
            flowInstance.CreateUserId = user.User.Id;
            flowInstance.CreateUserName = user.User.Account;
            flowInstance.MakerList = (wfruntime.GetNextNodeType() != 4 ? GetNextMakers(wfruntime) : "");
            flowInstance.IsFinish = (wfruntime.GetNextNodeType() == 4 ? 1 : 0);

            UnitWork.Add(flowInstance);
            wfruntime.flowInstanceId = flowInstance.Id;

            if (flowInstance.FrmType == 1)
            {
                var t = Type.GetType("OpenAuth.App."+ flowInstance.DbName +"App");
                ICustomerForm icf = (ICustomerForm) _serviceProvider.GetService(t);
                icf.Add(flowInstance.Id, flowInstance.FrmData);
            }

            #endregion 根据运行实例改变当前节点状态

            #region 流程操作记录

            FlowInstanceOperationHistory processOperationHistoryEntity = new FlowInstanceOperationHistory
            {
                InstanceId = flowInstance.Id,
                CreateUserId = user.User.Id,
                CreateUserName = user.User.Name,
                CreateDate = DateTime.Now,
                Content = "【创建】"
                          + user.User.Name
                          + "创建了一个流程进程【"
                          + addFlowInstanceReq.Code + "/"
                          + addFlowInstanceReq.CustomName + "】"
            };
            UnitWork.Add(processOperationHistoryEntity);

            #endregion 流程操作记录

            AddTransHistory(wfruntime);
            UnitWork.Save();
            return true;
        }

        /// <summary>
        /// 节点审核
        /// </summary>
        /// <param name="instanceId"></param>
        /// <returns></returns>
        public bool NodeVerification(string instanceId, Tag tag)
        {
            FlowInstance flowInstance = Get(instanceId);
            FlowInstanceOperationHistory flowInstanceOperationHistory = new FlowInstanceOperationHistory
            {
                InstanceId = instanceId,
                CreateUserId = tag.UserId,
                CreateUserName = tag.UserName,
                CreateDate = DateTime.Now
            };//操作记录
            FlowRuntime wfruntime = new FlowRuntime(flowInstance);

            #region 会签

            if (flowInstance.ActivityType == 0)//当前节点是会签节点
            {
                //会签时的【当前节点】一直是会签开始节点
                //TODO: 标记会签节点的状态，这个地方感觉怪怪的
                wfruntime.MakeTagNode(wfruntime.currentNodeId, tag);

                string canCheckId = ""; //寻找当前登录用户可审核的节点Id
                foreach (string fromForkStartNodeId in wfruntime.FromNodeLines[wfruntime.currentNodeId].Select(u => u.to))
                {
                    var fromForkStartNode = wfruntime.Nodes[fromForkStartNodeId];  //与会前开始节点直接连接的节点
                    canCheckId = GetOneForkLineCanCheckNodeId(fromForkStartNode, wfruntime, tag);
                    if(!string.IsNullOrEmpty(canCheckId)) break;
                }

                if (canCheckId == "")
                {
                    throw (new Exception("审核异常,找不到审核节点"));
                }

                flowInstanceOperationHistory.Content = "【" + wfruntime.Nodes[canCheckId].name
                                                           + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm")
                                                           + "】" + (tag.Taged == 1 ? "同意" : "不同意") + ",备注："
                                                           + tag.Description;

                wfruntime.MakeTagNode(canCheckId, tag); //标记审核节点状态
                string res = wfruntime.NodeConfluence(canCheckId, tag);
                if (res == TagState.No.ToString("D"))
                {
                    flowInstance.IsFinish = 3;
                }
                else if(!string.IsNullOrEmpty(res))
                {
                    flowInstance.PreviousId = flowInstance.ActivityId;
                    flowInstance.ActivityId = wfruntime.nextNodeId;
                    flowInstance.ActivityType = wfruntime.nextNodeType;
                    flowInstance.ActivityName = wfruntime.nextNode.name;
                    flowInstance.IsFinish = (wfruntime.nextNodeType == 4 ? 1 : 0);
                    flowInstance.MakerList =
                        (wfruntime.nextNodeType == 4 ? "" : GetNextMakers(wfruntime));

                    AddTransHistory(wfruntime);
                }
                else
                {
                    //会签过程中，需要更新用户
                    flowInstance.MakerList = GetForkNodeMakers(wfruntime, wfruntime.currentNodeId);
                    AddTransHistory(wfruntime);
                }
              
            }
            #endregion 会签

            #region 一般审核

            else
            {
                wfruntime.MakeTagNode(wfruntime.currentNodeId, tag);
                if (tag.Taged == (int) TagState.Ok)
                {
                    flowInstance.PreviousId = flowInstance.ActivityId;
                    flowInstance.ActivityId = wfruntime.nextNodeId;
                    flowInstance.ActivityType = wfruntime.nextNodeType;
                    flowInstance.ActivityName = wfruntime.nextNode.name;
                    flowInstance.MakerList = wfruntime.nextNodeType == 4 ? "" : GetNextMakers(wfruntime);
                    flowInstance.IsFinish = (wfruntime.nextNodeType == 4 ? 1 : 0);
                    AddTransHistory(wfruntime);
                }
                else
                {
                    flowInstance.IsFinish = 3; //表示该节点不同意
                }
                flowInstanceOperationHistory.Content = "【" + wfruntime.currentNode.name
                                                           + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm")
                                                           + "】" + (tag.Taged == 1 ? "同意" : "不同意") + ",备注："
                                                           + tag.Description;
            }

            #endregion 一般审核

            flowInstance.SchemeContent = JsonHelper.Instance.Serialize(wfruntime.ToSchemeObj());

            UnitWork.Update(flowInstance);
            UnitWork.Add(flowInstanceOperationHistory);
            UnitWork.Save();

            wfruntime.NotifyThirdParty(_httpClientFactory.CreateClient(), tag);
            return true;
        }

        //会签时，获取一条会签分支上面是否有用户可审核的节点
        private string GetOneForkLineCanCheckNodeId(FlowNode fromForkStartNode, FlowRuntime wfruntime, Tag tag)
        {
            string canCheckId="";
            var node = fromForkStartNode;
            do  //沿一条分支线路执行，直到遇到会签结束节点
            {
                var makerList = GetNodeMarkers(node);

                if (node.setInfo.Taged == null && !string.IsNullOrEmpty(makerList) && makerList.Split(',').Any(one => tag.UserId == one))
                {
                    canCheckId = node.id;
                    break;
                }

                node = wfruntime.GetNextNode(node.id);
            } while (node.type != FlowNode.JOIN);

            return canCheckId;
        }

        /// <summary>
        /// 驳回
        /// 如果NodeRejectStep不为空，优先使用；否则按照NodeRejectType驳回
        /// </summary>
        /// <returns></returns>
        public bool NodeReject(VerificationReq reqest)
        {
            var user = _auth.GetCurrentUser().User;

            FlowInstance flowInstance = Get(reqest.FlowInstanceId);

            FlowRuntime wfruntime = new FlowRuntime(flowInstance);

            string resnode = "";
            resnode = string.IsNullOrEmpty(reqest.NodeRejectStep) ? wfruntime.RejectNode(reqest.NodeRejectType) : reqest.NodeRejectStep;

            var tag = new Tag
            {
                Description = reqest.VerificationOpinion,
                Taged = (int) TagState.Reject,
                UserId = user.Id,
                UserName = user.Name
            };

            wfruntime.MakeTagNode(wfruntime.currentNodeId, tag);
            flowInstance.IsFinish = 4;//4表示驳回（需要申请者重新提交表单）
            if (resnode != "")
            {
                flowInstance.PreviousId = flowInstance.ActivityId;
                flowInstance.ActivityId = resnode;
                flowInstance.ActivityType = wfruntime.GetNodeType(resnode);
                flowInstance.ActivityName = wfruntime.Nodes[resnode].name;
                flowInstance.MakerList = GetNodeMarkers(wfruntime.Nodes[resnode]);//当前节点可执行的人信息

                AddTransHistory(wfruntime);
            }

            UnitWork.Update(flowInstance);

            UnitWork.Add(new FlowInstanceOperationHistory
            {
                InstanceId = reqest.FlowInstanceId
                ,
                CreateUserId = user.Id
                ,
                CreateUserName = user.Name
                ,
                CreateDate = DateTime.Now
                ,
                Content = "【"
                          + wfruntime.currentNode.name
                          + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】驳回,备注："
                          + reqest.VerificationOpinion
            });

            UnitWork.Save();

            wfruntime.NotifyThirdParty(_httpClientFactory.CreateClient(), tag);

            return true;
        }

        #endregion 流程处理API

        #region 获取各种节点的流程审核者
        /// <summary>
        /// 寻找下一步的执行人
        /// 一般用于本节点审核完成后，修改流程实例的当前执行人，可以做到通知等功能
        /// </summary>
        /// <returns></returns>
        private string GetNextMakers(FlowRuntime wfruntime)
        {
            string makerList = "";
            if (wfruntime.nextNodeId == "-1")
            {
                throw (new Exception("无法寻找到下一个节点"));
            }
            if (wfruntime.nextNodeType == 0)//如果是会签节点
            {
                makerList = GetForkNodeMakers(wfruntime, wfruntime.nextNodeId);
            }
            else
            {
                makerList = GetNodeMarkers(wfruntime.nextNode);
                if (string.IsNullOrEmpty(makerList))
                {
                    throw (new Exception("无法寻找到节点的审核者,请查看流程设计是否有问题!"));
                }
            }

            return makerList;
        }

        /// <summary>
        /// 获取会签开始节点的所有可执行者
        /// </summary>
        /// <param name="forkNodeId">会签开始节点</param>
        /// <returns></returns>
        private string GetForkNodeMakers(FlowRuntime wfruntime, string forkNodeId)
        {
            string makerList="";
            foreach (string fromForkStartNodeId in wfruntime.FromNodeLines[forkNodeId].Select(u => u.to))
            {
                var fromForkStartNode = wfruntime.Nodes[fromForkStartNodeId]; //与会前开始节点直接连接的节点
                if (makerList != "")
                {
                    makerList += ",";
                }

                makerList += GetOneForkLineMakers(fromForkStartNode, wfruntime);
            }

            return makerList;
        }

        //获取会签一条线上的审核者,该审核者应该是已审核过的节点的下一个人
        private string GetOneForkLineMakers(FlowNode fromForkStartNode, FlowRuntime wfruntime)
        {
            string markers="";
            var node = fromForkStartNode;
            do  //沿一条分支线路执行，直到遇到第一个没有审核的节点
            {
                if (node.setInfo != null && node.setInfo.Taged != null)  
                {
                    if (node.type != FlowNode.FORK && node.setInfo.Taged != (int) TagState.Ok)  //如果节点是不同意或驳回，则不用再找了
                    {
                        break;
                    }
                    node = wfruntime.GetNextNode(node.id);  //下一个节点
                    continue;
                }
                var marker = GetNodeMarkers(node);
                if (marker == "")
                {
                    throw (new Exception($"节点{node.name}没有审核者,请检查!"));
                }
                if (marker == "1")
                {
                    throw (new Exception($"节点{node.name}是会签节点，不能用所有人,请检查!"));
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

        /// <summary>
        /// 寻找该节点执行人
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        private string GetNodeMarkers(FlowNode node)
        {
            string makerList = "";

            if (node.setInfo != null)
            {
                if (node.setInfo.NodeDesignate == Setinfo.ALL_USER)//所有成员
                {
                    makerList = "1";
                }
                else if (node.setInfo.NodeDesignate == Setinfo.SPECIAL_USER)//指定成员
                {
                    makerList = GenericHelpers.ArrayToString(node.setInfo.NodeDesignateData.users, makerList);
                }
                else if (node.setInfo.NodeDesignate == Setinfo.SPECIAL_ROLE)  //指定角色
                {
                    var users = _revelanceApp.Get(Define.USERROLE, false, node.setInfo.NodeDesignateData.roles);
                    makerList = GenericHelpers.ArrayToString(users, makerList);
                }
            }
            else  //如果没有设置节点信息，默认所有人都可以审核
            {
                makerList = "1";
            }
            return makerList;
        }
        #endregion

        /// <summary>
        /// 审核流程
        /// <para>李玉宝于2017-01-20 15:44:45</para>
        /// </summary>
        public void Verification(VerificationReq request)
        {
            var user = _auth.GetCurrentUser().User;
            var tag = new Tag
            {
                UserName = user.Name,
                UserId = user.Id,
                Description = request.VerificationOpinion,
                Taged = Int32.Parse(request.VerificationFinally)
            };
            bool isReject = TagState.Reject.Equals((TagState) tag.Taged);
            if (isReject)  //驳回
            {
                NodeReject(request);
            }
            else
            {
                NodeVerification(request.FlowInstanceId, tag);
            }
        }

        public void Update(FlowInstance flowScheme)
        {
            Repository.Update(flowScheme);
        }

        public TableData Load(QueryFlowInstanceListReq request)
        {
            var result = new TableData();
            var user = _auth.GetCurrentUser();

            if (request.type == "wait")   //待办事项
            {
                Expression<Func<FlowInstance, bool>> waitExp = u => (u.MakerList == "1" || u.MakerList.Contains(user.User.Id)) && u.IsFinish == 0;

                // 加入搜索自定义标题
                if (!string.IsNullOrEmpty(request.key))
                {
                    waitExp = waitExp.And(t => t.CustomName.Contains(request.key));
                }

                result.count = UnitWork.Find(waitExp).Count();

                result.data = UnitWork.Find(request.page, request.limit, "CreateDate descending", waitExp).ToList();
            }
            else if (request.type == "disposed")  //已办事项（即我参与过的流程）
            {
                var instances = UnitWork.Find<FlowInstanceTransitionHistory>(u => u.CreateUserId == user.User.Id)
                    .Select(u => u.InstanceId).Distinct();
                var query = from ti in instances
                            join ct in UnitWork.Find<FlowInstance>(null) on ti equals ct.Id
                            select ct;

                // 加入搜索自定义标题
                if (!string.IsNullOrEmpty(request.key))
                {
                    query = query.Where(t => t.CustomName.Contains(request.key));
                }

                result.data = query.OrderByDescending(u => u.CreateDate)
                    .Skip((request.page - 1) * request.limit)
                    .Take(request.limit).ToList();
                result.count = instances.Count();
            }
            else  //我的流程
            {
                Expression<Func<FlowInstance, bool>> myFlowExp = u => u.CreateUserId == user.User.Id;

                // 加入搜索自定义标题
                if (!string.IsNullOrEmpty(request.key))
                {
                    myFlowExp = myFlowExp.And(t => t.CustomName.Contains(request.key));
                }

                result.count = UnitWork.Find(myFlowExp).Count();
                result.data = UnitWork.Find(request.page, request.limit,
                    "CreateDate descending", myFlowExp).ToList();
            }

            return result;
        }

        /// <summary>
        /// 添加扭转记录
        /// </summary>
        private void AddTransHistory(FlowRuntime wfruntime)
        {
            var tag = _auth.GetCurrentUser().User;
            UnitWork.Add(new FlowInstanceTransitionHistory
            {
                InstanceId = wfruntime.flowInstanceId,
                CreateUserId = tag.Id,
                CreateUserName = tag.Name,
                FromNodeId = wfruntime.currentNodeId,
                FromNodeName = wfruntime.currentNode.name,
                FromNodeType = wfruntime.currentNodeType,
                ToNodeId = wfruntime.nextNodeId,
                ToNodeName = wfruntime.nextNode.name,
                ToNodeType = wfruntime.nextNodeType,
                IsFinish = wfruntime.nextNodeType == 4 ? 1 : 0,
                TransitionSate = 0
            });
        }

        public FlowInstanceApp(IUnitWork unitWork, IRepository<FlowInstance> repository
        , RevelanceManagerApp app, FlowSchemeApp flowSchemeApp, FormApp formApp, IHttpClientFactory httpClientFactory,IAuth auth, IServiceProvider serviceProvider) 
            : base(unitWork, repository, auth)
        {
            _revelanceApp = app;
            _flowSchemeApp = flowSchemeApp;
            _formApp = formApp;
            _httpClientFactory = httpClientFactory;
            _serviceProvider = serviceProvider;
        }

        public List<FlowInstanceOperationHistory> QueryHistories(QueryFlowInstanceHistoryReq request)
        {
            return UnitWork.Find<FlowInstanceOperationHistory>(u => u.InstanceId == request.FlowInstanceId)
                .OrderByDescending(u => u.CreateDate).ToList();
        }
    }
}