using Infrastructure;
using OpenAuth.App.Flow;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Castle.Core.Internal;
using Infrastructure.Const;
using Infrastructure.Extensions;
using Infrastructure.Helpers;
using Newtonsoft.Json.Linq;
using SqlSugar;
using Yitter.IdGenerator;

namespace OpenAuth.App
{
    /// <summary>
    /// 工作流实例表操作
    /// </summary>
    public class FlowInstanceApp : SqlSugarBaseApp<FlowInstance>
    {
        private RevelanceManagerApp _revelanceApp;
        private FlowSchemeApp _flowSchemeApp;
        private FormApp _formApp;
        private IHttpClientFactory _httpClientFactory;
        private IServiceProvider _serviceProvider;
        private SysMessageApp _messageApp;
        private DbExtension _dbExtension;
        private UserManagerApp _userManagerApp;
        private OrgManagerApp _orgManagerApp;
        private FlowApproverApp _flowApproverApp;
        private RevelanceManagerApp _revelanceManagerApp;


        #region 流程处理API

        /// <summary>
        /// 创建一个实例
        /// </summary>
        /// <returns></returns>
        public bool CreateInstance(AddFlowInstanceReq addFlowInstanceReq)
        {
            CheckNodeDesignate(addFlowInstanceReq);
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
            addFlowInstanceReq.CreateUserId = user.User.Id;
            flowInstance.CreateUserName = user.User.Account;
            addFlowInstanceReq.CreateUserName = user.User.Account;

            flowInstance.MakerList =
                (wfruntime.GetNextNodeType() != 4 ? GetNextMakers(wfruntime, addFlowInstanceReq) : "");
            flowInstance.IsFinish = (wfruntime.GetNextNodeType() == 4
                ? FlowInstanceStatus.Finished
                : FlowInstanceStatus.Running);


            SugarClient.Ado.BeginTran();
            SugarClient.Insertable(flowInstance).ExecuteCommand();
            wfruntime.flowInstanceId = flowInstance.Id;

            if (flowInstance.FrmType == 1) //如果是开发者自定义的表单
            {
                var t = Type.GetType("OpenAuth.App." + flowInstance.DbName + "App");
                ICustomerForm icf = (ICustomerForm)_serviceProvider.GetService(t);
                try
                {
                    icf.Add(flowInstance.Id, flowInstance.FrmData);
                }
                catch (Exception e)
                {
                    throw new Exception("流程表单数据解析失败,请检查表单是否填写完整");
                }
            }

            //如果工作流配置的表单配置有对应的数据库
            if (!string.IsNullOrEmpty(form.DbName))
            {
                var dbcolumns = _dbExtension.GetDbTableStructure(form.DbName);
                var json = JsonHelper.Instance.Deserialize<JObject>(addFlowInstanceReq.FrmData);
                var columnstr = string.Empty; //字段
                var valstr = string.Empty; //值字符串


                foreach (var column in dbcolumns)
                {
                    if (column.ColumnName == "Id" || column.ColumnName == "id")
                    {
                        var options = new IdGeneratorOptions()
                        {
                            Method = 1,
                            WorkerId = 1
                        };

                        YitIdHelper.SetIdGenerator(options);
                        columnstr += "Id,";
                        valstr += "'" + YitIdHelper.NextId().ToString() + "',";
                        continue;
                    }

                    //讲流程实例ID赋值到表单数据表中，实现表单记录与流程实例关联
                    if (column.ColumnName == Define.DEFAULT_FORM_INSTANCE_ID_NAME)
                    {
                        columnstr += $"{Define.DEFAULT_FORM_INSTANCE_ID_NAME},";
                        valstr += "'" + flowInstance.Id + "',";
                        continue;
                    }

                    var val = json[column.ColumnName];
                    if (val == null)
                    {
                        switch (column.EntityType)
                        {
                            case "int":
                                val = 0;
                                break;
                            case "string":
                                val = "";
                                break;
                            case "DateTime":
                                val = DateTime.Now.ToString("yyyy-MM-dd");
                                break;
                        }
                    }

                    if (val == null) continue;
                    columnstr += column.ColumnName + ",";
                    valstr += "'" + val + "',";
                }

                columnstr = columnstr.TrimEnd(',');
                valstr = valstr.TrimEnd(',');
                var sql = $"insert into {form.DbName}({columnstr}) values ({valstr})";
                SugarClient.Ado.ExecuteCommand(sql);
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
            SugarClient.Insertable(processOperationHistoryEntity).ExecuteCommand();

            #endregion 流程操作记录

            AddTransHistory(wfruntime);
            SugarClient.Ado.CommitTran();
            return true;
        }

        /// <summary>
        /// 更新流程
        /// <para>更新时可以修改表单内容，可以修改流程基本信息，但不能更换表单模版</para>
        /// </summary>
        /// <param name="req"></param>
        public void Update(UpdateFlowInstanceReq req)
        {
            var flowinstance = Get(req.Id);

            if (flowinstance.IsFinish != FlowInstanceStatus.Draft &&
                flowinstance.IsFinish != FlowInstanceStatus.Rejected)
            {
                throw new Exception("只能修改【草稿】和【驳回】状态的流程");
            }

            var form = _formApp.Get(flowinstance.FrmId);

            if (form != null)
            {
                if (form.FrmType == 1) //如果是开发者自定义的表单,更新对应数据库表数据
                {
                    var t = Type.GetType("OpenAuth.App." + req.DbName + "App");
                    ICustomerForm icf = (ICustomerForm)_serviceProvider.GetService(t);
                    icf.Update(req.Id, req.FrmData);
                }
                else if (form.FrmType == 2 && !string.IsNullOrEmpty(form.DbName)) //拖拽表单定义了关联数据库
                {
                    var dbcolumns = _dbExtension.GetDbTableStructure(form.DbName);
                    var json = JsonHelper.Instance.Deserialize<JObject>(req.FrmData);
                    var updatestr = string.Empty; //字段

                    foreach (var column in dbcolumns)
                    {
                        if (column.ColumnName == "Id" || column.ColumnName == "id")
                        {
                            continue;
                        }

                        //流程实例ID不能修改
                        if (column.ColumnName == Define.DEFAULT_FORM_INSTANCE_ID_NAME)
                        {
                            continue;
                        }

                        var val = json[column.ColumnName];
                        if (val == null)
                        {
                            continue;
                        }

                        updatestr += $"{column.ColumnName} = '{val}',";
                    }

                    updatestr = updatestr.TrimEnd(',');
                    if (!string.IsNullOrEmpty(updatestr))
                    {
                        var sql =
                            $"update {form.DbName} set {updatestr} where {Define.DEFAULT_FORM_INSTANCE_ID_NAME}='{req.Id}'";
                        SugarClient.Ado.ExecuteCommand(sql);
                    }
                }
            }

            flowinstance.Description = req.Description;
            flowinstance.Code = req.Code;
            flowinstance.FrmData = req.FrmData;
            flowinstance.DbName = req.DbName;
            flowinstance.CustomName = req.CustomName;
            SugarClient.Updateable(flowinstance).ExecuteCommand();
        }

        /// <summary>
        /// 节点审核
        /// </summary>
        /// <param name="instanceId"></param>
        /// <returns></returns>
        public bool NodeVerification(VerificationReq request)
        {
            var user = _auth.GetCurrentUser().User;
            var instanceId = request.FlowInstanceId;

            var tag = new Tag
            {
                UserName = user.Name,
                UserId = user.Id,
                Description = request.VerificationOpinion,
                Taged = Int32.Parse(request.VerificationFinally)
            };

            FlowInstance flowInstance = Get(instanceId);
            var approvers = _flowApproverApp.GetApproverIds(new QueryApproverReq
            {
                FlowInstanceId = instanceId,
                ActivityId = flowInstance.ActivityId
            });

            if (flowInstance.MakerList != "1" && !flowInstance.MakerList.Contains(user.Id) &&
                !approvers.Contains(user.Id))
            {
                throw new Exception("当前用户没有审批该节点权限");
            }

            FlowRuntime wfruntime = new FlowRuntime(flowInstance);

            #region 会签

            if (flowInstance.ActivityType == 0) //当前节点是会签节点
            {
                //会签时的【当前节点】一直是会签开始节点
                //TODO: 标记会签节点的状态，这个地方感觉怪怪的
                wfruntime.MakeTagNode(wfruntime.currentNodeId, tag);

                string canCheckId = ""; //寻找当前登录用户可审核的节点Id
                foreach (string fromForkStartNodeId in wfruntime.FromNodeLines[wfruntime.currentNodeId]
                             .Select(u => u.to))
                {
                    var fromForkStartNode = wfruntime.Nodes[fromForkStartNodeId]; //与会前开始节点直接连接的节点
                    canCheckId = GetOneForkLineCanCheckNodeId(fromForkStartNode, wfruntime, tag);
                    if (!string.IsNullOrEmpty(canCheckId)) break;
                }

                if (canCheckId == "")
                {
                    throw (new Exception("审核异常,找不到审核节点"));
                }

                var content =
                    $"{user.Account}-{DateTime.Now.ToString("yyyy-MM-dd HH:mm")}审批了【{wfruntime.Nodes[canCheckId].name}】" +
                    $"结果：{(tag.Taged == 1 ? "同意" : "不同意")}，备注：{tag.Description}";
                AddOperationHis(instanceId, tag, content);

                wfruntime.MakeTagNode(canCheckId, tag); //标记审核节点状态
                string res = wfruntime.NodeConfluence(canCheckId, tag);
                if (res == TagState.No.ToString("D"))
                {
                    flowInstance.IsFinish = FlowInstanceStatus.Disagree;
                }
                else if (!string.IsNullOrEmpty(res))
                {
                    flowInstance.PreviousId = flowInstance.ActivityId;
                    flowInstance.ActivityId = wfruntime.nextNodeId;
                    flowInstance.ActivityType = wfruntime.nextNodeType;
                    flowInstance.ActivityName = wfruntime.nextNode.name;
                    flowInstance.IsFinish = (wfruntime.nextNodeType == 4
                        ? FlowInstanceStatus.Finished
                        : FlowInstanceStatus.Running);
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

                flowInstance.SchemeContent = JsonHelper.Instance.Serialize(wfruntime.ToSchemeObj());
            }

            #endregion 会签

            #region 一般审核

            else
            {
                VerifyNode(request, tag, flowInstance);
            }

            #endregion 一般审核

            //自定义开发表单，需要更新对应的数据库
            if (!string.IsNullOrEmpty(request.FrmData) && flowInstance.FrmType == 1)
            {
                var t = Type.GetType("OpenAuth.App." + flowInstance.DbName + "App");
                ICustomerForm icf = (ICustomerForm)_serviceProvider.GetService(t);
                icf.Update(flowInstance.Id, flowInstance.FrmData);
            }


            SugarClient.Updateable(flowInstance).ExecuteCommand();
            //给流程创建人发送通知信息
            _messageApp.SendMsgTo(flowInstance.CreateUserId,
                $"你的流程[{flowInstance.CustomName}]已被{user.Name}处理。");

            SugarClient.Ado.CommitTran();

            wfruntime.NotifyThirdParty(_httpClientFactory.CreateClient(), tag);
            return true;
        }

        /// <summary>
        /// 普通的节点审批
        /// </summary>
        private void VerifyNode(VerificationReq request, Tag tag, FlowInstance flowInstance)
        {
            var user = _auth.GetCurrentUser().User;

            if (!string.IsNullOrEmpty(request.FrmData))
            {
                flowInstance.FrmData = request.FrmData;
            }

            FlowRuntime wfruntime = new FlowRuntime(flowInstance);
            wfruntime.MakeTagNode(wfruntime.currentNodeId, tag);
            if (tag.Taged == (int)TagState.Ok)
            {
                bool canNext = true;
                var approvers = _flowApproverApp.GetApprovers(new QueryApproverReq
                {
                    FlowInstanceId = flowInstance.Id,
                    ActivityId = flowInstance.ActivityId
                });

                var approverInfo = approvers?.Find(u => u.ApproverId == user.Id);
                if (approverInfo != null)
                {
                    //如果是加签，则调整加签状态
                    bool isfinish = _flowApproverApp.Verify(new VerifyApproverReq()
                    {
                        Id = approverInfo.Id,
                        Status = (int)TagState.Ok,
                        VerifyComment = tag.Description
                    });
                    if (!isfinish) //如果没有完成，不能到下一步
                    {
                        canNext = false;
                    }
                    else if (approverInfo.ReturnToSignNode == null || !approverInfo.ReturnToSignNode.Value)
                    {
                        //加签完成后，不需要返回原节点,则直接审批加签的节点
                        tag.UserId = approverInfo.CreateUserId;
                        tag.UserName = approverInfo.CreateUserName;
                        //把当前审批人变成加签人，从而可以自动审批
                        wfruntime.MakeTagNode(wfruntime.currentNodeId, tag);
                    }
                }

                if (wfruntime.currentNode.setInfo.NodeDesignate == Setinfo.RUNTIME_MANY_PARENTS)
                {
                    List<string> roles;
                    if (user.Id != tag.UserId)
                    {
                        //最后一个执行加签的用户，tag.UserId就是加签人id，需要找他的角色
                        roles = _revelanceManagerApp.Get(Define.USERROLE, true, tag.UserId);
                    }
                    else
                    {
                        roles = _auth.GetCurrentUser().Roles.Select(u => u.Id).ToList();
                    }

                    //如果是连续多级直属上级且还没到指定的角色，只改变执行人，不到下一个节点
                    if (!wfruntime.currentNode.setInfo.NodeDesignateData.roles.Intersect(roles).Any())
                    {
                        canNext = false;
                        var parentId = _userManagerApp.GetParent(tag.UserId);
                        flowInstance.MakerList = parentId;
                    }
                }

                if (canNext)
                {
                    flowInstance.PreviousId = flowInstance.ActivityId;
                    flowInstance.ActivityId = wfruntime.nextNodeId;
                    flowInstance.ActivityType = wfruntime.nextNodeType;
                    flowInstance.ActivityName = wfruntime.nextNode.name;
                    flowInstance.MakerList = wfruntime.nextNodeType == 4 ? "" : GetNextMakers(wfruntime, request);
                    flowInstance.IsFinish = (wfruntime.nextNodeType == 4
                        ? FlowInstanceStatus.Finished
                        : FlowInstanceStatus.Running);
                }
            }
            else //审批结果为不同意
            {
                flowInstance.IsFinish = FlowInstanceStatus.Disagree;
                wfruntime.nextNodeId = "-1";
                wfruntime.nextNodeType = 4;
            }

            var content =
                $"{user.Account}-{DateTime.Now.ToString("yyyy-MM-dd HH:mm")}审批了【{wfruntime.currentNode.name}】" +
                $"结果：{(tag.Taged == 1 ? "同意" : "不同意")}，备注：{tag.Description}";
            AddOperationHis(flowInstance.Id, tag, content);
            flowInstance.SchemeContent = JsonHelper.Instance.Serialize(wfruntime.ToSchemeObj());

            //如果审批通过，且下一个审批人是自己，则自动审批
            if (tag.Taged == (int)TagState.Ok)
            {
                if (flowInstance.MakerList != "1" && (!flowInstance.MakerList.Contains(user.Id)))
                {
                    return;
                }

                VerifyNode(request, tag, flowInstance);
            }
        }

        //会签时，获取一条会签分支上面是否有用户可审核的节点
        private string GetOneForkLineCanCheckNodeId(FlowNode fromForkStartNode, FlowRuntime wfruntime, Tag tag)
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
            if (flowInstance.MakerList != "1" && !flowInstance.MakerList.Contains(user.Id))
            {
                throw new Exception("当前用户没有驳回该节点权限");
            }

            FlowRuntime wfruntime = new FlowRuntime(flowInstance);

            string rejectNode = ""; //驳回的节点
            rejectNode = string.IsNullOrEmpty(reqest.NodeRejectStep)
                ? wfruntime.RejectNode(reqest.NodeRejectType)
                : reqest.NodeRejectStep;

            var tag = new Tag
            {
                Description = reqest.VerificationOpinion,
                Taged = (int)TagState.Reject,
                UserId = user.Id,
                UserName = user.Name
            };

            wfruntime.MakeTagNode(wfruntime.currentNodeId, tag);
            flowInstance.IsFinish = FlowInstanceStatus.Rejected; //4表示驳回（需要申请者重新提交表单）
            if (rejectNode != "")
            {
                flowInstance.PreviousId = flowInstance.ActivityId;
                flowInstance.ActivityId = rejectNode;
                flowInstance.ActivityType = wfruntime.GetNodeType(rejectNode);
                flowInstance.ActivityName = wfruntime.Nodes[rejectNode].name;
                flowInstance.MakerList = GetNodeMarkers(wfruntime.Nodes[rejectNode], flowInstance.CreateUserId);

                AddTransHistory(wfruntime);
            }

            flowInstance.SchemeContent = JsonHelper.Instance.Serialize(wfruntime.ToSchemeObj());
            SugarClient.Updateable(flowInstance).ExecuteCommand();

            SugarClient.Insertable(new FlowInstanceOperationHistory
            {
                InstanceId = reqest.FlowInstanceId,
                CreateUserId = user.Id,
                CreateUserName = user.Name,
                CreateDate = DateTime.Now,
                Content = "【"
                          + wfruntime.currentNode.name
                          + "】【" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "】驳回,备注："
                          + reqest.VerificationOpinion
            }).ExecuteCommand();

            //给流程创建人发送通知信息
            _messageApp.SendMsgTo(flowInstance.CreateUserId,
                $"你的流程[{flowInstance.CustomName}]已被{user.Name}驳回。备注信息:{reqest.VerificationOpinion}");

            SugarClient.Ado.CommitTran();

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
        private string GetNextMakers(FlowRuntime wfruntime, NodeDesignateReq request = null)
        {
            string makerList = "";
            if (wfruntime.nextNodeId == "-1")
            {
                throw (new Exception("无法寻找到下一个节点"));
            }

            if (wfruntime.nextNodeType == 0) //如果是会签节点
            {
                makerList = GetForkNodeMakers(wfruntime, wfruntime.nextNodeId);
            }
            else if (wfruntime.nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_ROLE)
            {
                //如果是运行时指定角色
                if (wfruntime.nextNode.setInfo.NodeDesignate != request.NodeDesignateType)
                {
                    throw new Exception("前端提交的节点权限类型异常，请检查流程");
                }

                var users = _revelanceApp.Get(Define.USERROLE, false, request.NodeDesignates);
                makerList = GenericHelpers.ArrayToString(users, makerList);
            }
            else if (wfruntime.nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_USER)
            {
                //如果是运行时指定用户
                if (wfruntime.nextNode.setInfo.NodeDesignate != request.NodeDesignateType)
                {
                    throw new Exception("前端提交的节点权限类型异常，请检查流程");
                }

                makerList = GenericHelpers.ArrayToString(request.NodeDesignates, makerList);
            }
            else if (wfruntime.nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_PARENT
                     || wfruntime.nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_MANY_PARENTS)
            {
                //如果是上一节点执行人的直属上级或连续多级直属上级
                if (wfruntime.nextNode.setInfo.NodeDesignate != request.NodeDesignateType)
                {
                    throw new Exception("前端提交的节点权限类型异常，请检查流程");
                }

                //当创建流程时，肯定执行的开始节点，登录用户就是创建用户
                //当审批流程时，能进到这里，表明当前登录用户已经有审批当前节点的权限，完全可以直接用登录用户的直接上级
                var user = _auth.GetCurrentUser().User;
                var parentId = _userManagerApp.GetParent(user.Id);
                if (StringExtension.IsNullOrEmpty(parentId))
                {
                    throw new Exception("无法找到当前用户的直属上级");
                }

                makerList = GenericHelpers.ArrayToString(new[] { parentId }, makerList);
            }
            else if (wfruntime.nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_CHAIRMAN)
            {
                //如果是发起人的部门负责人
                if (wfruntime.nextNode.setInfo.NodeDesignate != request.NodeDesignateType)
                {
                    throw new Exception("前端提交的节点权限类型异常，请检查流程");
                }

                FlowInstance flowInstance = Get(wfruntime.flowInstanceId);
                var chairmanIds = _orgManagerApp.GetChairmanId(wfruntime.nextNode.setInfo.NodeDesignateData.orgs);
                makerList = GenericHelpers.ArrayToString(chairmanIds, makerList);
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
            string makerList = "";
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

                    node = wfruntime.GetNextNode(node.id); //下一个节点
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
        private string GetNodeMarkers(FlowNode node, string flowinstanceCreateUserId = "")
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
                    var users = _revelanceApp.Get(Define.USERROLE, false, node.setInfo.NodeDesignateData.roles);
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

        #endregion

        /// <summary>
        /// 审核流程
        /// <para>李玉宝于2017-01-20 15:44:45</para>
        /// </summary>
        public void Verification(VerificationReq request)
        {
            //如果是同意，需要判断是否为运行时选定下一步执行角色/执行人
            if (request.VerificationFinally == "1")
            {
                CheckNodeDesignate(request);
            }

            bool isReject = TagState.Reject.Equals((TagState)Int32.Parse(request.VerificationFinally));
            if (isReject) //驳回
            {
                NodeReject(request);
            }
            else
            {
                NodeVerification(request);
            }
        }

        /// <summary>
        /// 判定节点需要选择执行人或执行角色
        /// </summary>
        /// <param name="request"></param>
        /// <exception cref="Exception"></exception>
        private void CheckNodeDesignate(NodeDesignateReq request)
        {
            if ((request.NodeDesignateType == Setinfo.RUNTIME_SPECIAL_ROLE
                 || request.NodeDesignateType == Setinfo.RUNTIME_SPECIAL_USER) && request.NodeDesignates.Length == 0)
            {
                throw new Exception("下个节点需要选择执行人或执行角色");
            }
        }

        /// <summary>
        /// 返回用于处理流程节点
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public FlowVerificationResp GetForVerification(string id)
        {
            var flowinstance = Get(id);
            var resp = flowinstance.MapTo<FlowVerificationResp>();
            var runtime = new FlowRuntime(flowinstance);
            if (runtime.currentNode != null && runtime.currentNode.setInfo != null)
            {
                resp.CanWriteFormItemIds = runtime.currentNode.setInfo.CanWriteFormItemIds;
            }

            if (runtime.nextNode != null && runtime.nextNode.setInfo != null && runtime.nextNodeType != 4)
            {
                resp.NextNodeDesignateType = runtime.nextNode.setInfo.NodeDesignate;
                resp.CanWriteFormItemIds = runtime.currentNode.setInfo.CanWriteFormItemIds;
            }

            return resp;
        }

        public async Task<TableData> Load(QueryFlowInstanceListReq request)
        {
            var result = new TableData();
            var user = _auth.GetCurrentUser();

            if (request.type == "wait") //待办事项
            {
                var query = SugarClient.SqlQueryable<FlowInstance>($@"
            SELECT fi.*
            FROM FlowInstance fi
            JOIN (SELECT fith.Id
               FROM FlowInstance fith
               WHERE (MakerList = '1' or MakerList LIKE '%{user.User.Id}%') 
                 and (fith.IsFinish = {FlowInstanceStatus.Running} or fith.IsFinish = {FlowInstanceStatus.Rejected}) 
               UNION
               SELECT fa.InstanceId
               FROM FlowApprover fa 
               WHERE fa.Status = 0 
                 AND fa.ApproverId = '{user.User.Id}') AS UniqueInstanceIds
              ON fi.Id = UniqueInstanceIds.Id")
                    .WhereIF(!string.IsNullOrEmpty(request.key), t => t.CustomName.Contains(request.key));

                result.count = await query.CountAsync();
                result.data = await query.OrderByDescending(u => u.CreateDate)
                    .ToPageListAsync(request.page, request.limit);
            }
            else if (request.type == "disposed") //已办事项（即我参与过的流程）
            {
                var finalQuery = SugarClient.SqlQueryable<FlowInstance>($@"
                    SELECT fi.*
                    FROM FlowInstance fi
                             JOIN (SELECT fith.InstanceId
                                   FROM FlowInstanceTransitionHistory fith
                                   WHERE fith.CreateUserId = '{user.User.Id}' 
                                   UNION
                                   SELECT fa.InstanceId
                                   FROM FlowApprover fa 
                                   WHERE fa.Status <> 0 
                                     AND fa.ApproverId = '{user.User.Id}') AS UniqueInstanceIds
                                  ON fi.Id = UniqueInstanceIds.InstanceId
                    ")
                    .WhereIF(!string.IsNullOrEmpty(request.key), t => t.CustomName.Contains(request.key));

                result.data = await finalQuery.OrderByDescending(i => i.CreateDate)
                    .ToPageListAsync(request.page, request.limit);
                result.count = await finalQuery.CountAsync();
            }
            else //我的流程
            {
                var query = SugarClient.Queryable<FlowInstance>().Where(u => u.CreateUserId == user.User.Id);
                if (!string.IsNullOrEmpty(request.key))
                {
                    query = query.Where(t => t.CustomName.Contains(request.key));
                }

                result.count = await query.CountAsync();
                result.data = await query.OrderByDescending(u => u.CreateDate)
                    .ToPageListAsync(request.page, request.limit);
            }

            return result;
        }

        /// <summary>
        /// 添加扭转记录
        /// </summary>
        private void AddTransHistory(FlowRuntime wfruntime)
        {
            var tag = _auth.GetCurrentUser().User;
            SugarClient.Insertable(new FlowInstanceTransitionHistory
            {
                InstanceId = wfruntime.flowInstanceId,
                CreateUserId = tag.Id,
                CreateUserName = tag.Name,
                FromNodeId = wfruntime.currentNodeId,
                FromNodeName = wfruntime.currentNode.name,
                FromNodeType = wfruntime.currentNodeType,
                ToNodeId = wfruntime.nextNodeId,
                ToNodeName = wfruntime.nextNode?.name,
                ToNodeType = wfruntime.nextNodeType,
                IsFinish = wfruntime.nextNodeType == 4 ? FlowInstanceStatus.Finished : FlowInstanceStatus.Running,
                TransitionSate = 0
            }).ExecuteCommand();
        }

        private void AddOperationHis(string instanceId, Tag tag, string content)
        {
            FlowInstanceOperationHistory flowInstanceOperationHistory = new FlowInstanceOperationHistory
            {
                InstanceId = instanceId,
                CreateUserId = tag.UserId,
                CreateUserName = tag.UserName,
                CreateDate = DateTime.Now,
                Content = content
            }; //操作记录

            SugarClient.Insertable(flowInstanceOperationHistory).ExecuteCommand();
        }

        public List<FlowInstanceOperationHistory> QueryHistories(QueryFlowInstanceHistoryReq request)
        {
            return SugarClient.Queryable<FlowInstanceOperationHistory>()
                .Where(u => u.InstanceId == request.FlowInstanceId)
                .OrderByDescending(u => u.CreateDate).ToList();
        }

        /// <summary>
        /// 召回流程
        /// </summary>
        public void ReCall(RecallFlowInstanceReq request)
        {
            var user = _auth.GetCurrentUser().User;
            FlowInstance flowInstance = Get(request.FlowInstanceId);
            if (flowInstance.IsFinish == FlowInstanceStatus.Draft
                || flowInstance.IsFinish == FlowInstanceStatus.Finished)
            {
                throw new Exception("当前流程状态不能召回");
            }

            FlowRuntime wfruntime = new FlowRuntime(flowInstance);

            string startNodeId = wfruntime.startNodeId; //起始节点

            wfruntime.ReCall();

            flowInstance.IsFinish = FlowInstanceStatus.Draft;
            flowInstance.PreviousId = flowInstance.ActivityId;
            flowInstance.ActivityId = startNodeId;
            flowInstance.ActivityType = wfruntime.GetNodeType(startNodeId);
            flowInstance.ActivityName = wfruntime.Nodes[startNodeId].name;
            flowInstance.MakerList = GetNodeMarkers(wfruntime.Nodes[startNodeId], flowInstance.CreateUserId);

            AddTransHistory(wfruntime);

            SugarClient.Updateable(flowInstance).ExecuteCommand();

            SugarClient.Insertable(new FlowInstanceOperationHistory
            {
                InstanceId = request.FlowInstanceId,
                CreateUserId = user.Id,
                CreateUserName = user.Name,
                CreateDate = DateTime.Now,
                Content = $"【撤销】由{user.Name}撤销,备注：{request.Description}"
            }).ExecuteCommand();

            SugarClient.Ado.CommitTran();
        }

        /// <summary>启动流程</summary>
        /// <remarks> 通常是对状态为【草稿】的流程进行操作，进入运行状态 </remarks>
        public void Start(StartFlowInstanceReq request)
        {
            FlowInstance flowInstance = Get(request.FlowInstanceId);
            if (flowInstance.IsFinish != FlowInstanceStatus.Draft)
            {
                throw new Exception("当前流程不是草稿状态，不能启动");
            }

            var wfruntime = new FlowRuntime(flowInstance);
            var user = _auth.GetCurrentUser();

            if (wfruntime.nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_USER
                || wfruntime.nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_ROLE)
            {
                throw new Exception("暂不支持【第二执行节点为运行时指定角色/账号执行】的流程恢复");
            }

            #region 根据运行实例改变当前节点状态

            flowInstance.ActivityId = wfruntime.nextNodeId;
            flowInstance.ActivityType = wfruntime.GetNextNodeType();
            flowInstance.ActivityName = wfruntime.nextNode.name;
            flowInstance.PreviousId = wfruntime.currentNodeId;
            flowInstance.CreateUserId = user.User.Id;
            flowInstance.CreateUserName = user.User.Account;
            flowInstance.MakerList = (wfruntime.GetNextNodeType() != 4 ? GetNextMakers(wfruntime) : "");
            flowInstance.IsFinish = (wfruntime.GetNextNodeType() == 4
                ? FlowInstanceStatus.Finished
                : FlowInstanceStatus.Running);

            SugarClient.Updateable(flowInstance).ExecuteCommand();

            #endregion 根据运行实例改变当前节点状态

            #region 流程操作记录

            FlowInstanceOperationHistory processOperationHistoryEntity = new FlowInstanceOperationHistory
            {
                InstanceId = flowInstance.Id,
                CreateUserId = user.User.Id,
                CreateUserName = user.User.Name,
                CreateDate = DateTime.Now,
                Content = $"【启动】由用户{user.User.Name}启动"
            };
            SugarClient.Insertable(processOperationHistoryEntity).ExecuteCommand();

            #endregion 流程操作记录

            AddTransHistory(wfruntime);
            SugarClient.Ado.CommitTran();
        }

        public FlowInstanceApp(ISqlSugarClient client, IAuth auth, RevelanceManagerApp revelanceApp,
            FlowSchemeApp flowSchemeApp, FormApp formApp, IHttpClientFactory httpClientFactory,
            SysMessageApp messageApp, UserManagerApp userManagerApp, OrgManagerApp orgManagerApp,
            IServiceProvider serviceProvider, FlowApproverApp flowApproverApp,
            RevelanceManagerApp revelanceManagerApp) : base(client, auth)
        {
            _revelanceApp = revelanceApp;
            _flowSchemeApp = flowSchemeApp;
            _formApp = formApp;
            _httpClientFactory = httpClientFactory;
            _messageApp = messageApp;
            _userManagerApp = userManagerApp;
            _orgManagerApp = orgManagerApp;
            _serviceProvider = serviceProvider;
            _flowApproverApp = flowApproverApp;
            _revelanceManagerApp = revelanceManagerApp;
        }
    }
}