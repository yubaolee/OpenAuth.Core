using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using Quartz.Listener;
using SqlSugar;


namespace OpenAuth.App
{
    public class FlowApproverApp : SqlSugarBaseApp<FlowApprover>
    {
        /// <summary>
        /// 加签
        /// </summary>
        public void Add(AddApproverReq obj)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            //先删除已有的加签记录
            Repository.Delete(u => u.InstanceId == obj.InstanceId && u.ActivityId == obj.ActivityId);

            var objs =new  List<FlowApprover>();
            foreach (var approver in obj.Approvers)
            {
                var addobj = approver.MapTo<FlowApprover>();
                if (string.IsNullOrEmpty(addobj.Id))
                {
                    addobj.Id = Guid.NewGuid().ToString();
                }
                
                CaculateCascade(addobj);
                addobj.InstanceId = obj.InstanceId;
                addobj.ActivityId = obj.ActivityId;
                addobj.ApproveType = obj.ApproveType;
                addobj.Reason = obj.Reason;
                addobj.CreateDate = DateTime.Now;
                addobj.CreateUserId = loginContext.User.Id;
                addobj.CreateUserName = loginContext.User.Name;
                objs.Add(addobj);
            }

            Repository.InsertRange(objs);
        }

        public void Update(AddApproverReq application)
        {
            var updateobj = application.MapTo<FlowApprover>();
            Repository.Update(updateobj);
        }

        /// <summary>
        /// 加载当前节点的加签人
        /// </summary>
        public async Task<TableResp<FlowApprover>> Load(QueryApproverReq request)
        {
            var objs = await Repository.GetListAsync(u =>
                u.InstanceId == request.FlowInstanceId && u.ActivityId == request.ActivityId);
            return new TableResp<FlowApprover>()
            {
                data = objs
            };
        }

        /// <summary>
        /// 获取当前可以审批的加签人ID列表
        /// <para>如果是顺序执行，取第一个人</para>
        /// <para>否则并行且/并行或都是返回所有加签人</para>
        /// </summary>
        public string[] GetApproverIds(QueryApproverReq req)
        {
            var approvers = GetApprovers(req);
            if (approvers == null)
            {
                return Array.Empty<string>();
            }
            //否则并行且/并行或都是返回所有加签人
            return approvers.Select(u => u.ApproverId).ToArray();
        }
        
        /// <summary>
        /// 获取当前可以审批的加签人列表
        /// <para>如果是顺序执行，取第一个人</para>
        /// <para>否则并行且/并行或都是返回所有加签人</para>
        /// </summary>
        public FlowApprover[] GetApprovers(QueryApproverReq req)
        {
            var query= Repository.AsQueryable()
                .Where(u => u.InstanceId == req.FlowInstanceId 
                            && u.ActivityId == req.ActivityId && u.Status == 0); //本节点待审批的加签人
            if (query.Count() == 0)
            {
                return null;
            }
            
            //如果是顺序执行，取第一个人
            if (query.First().ApproveType == 0)
            {
                var result = query.OrderBy(u => u.OrderNo).First();
                return new[] { result };
            }
            //否则并行且/并行或都是返回所有加签人
            return query.ToArray();
        }
        
        /// <summary>
        /// 审批加签节点
        /// </summary>
        public bool Verify(VerifyApproverReq verifyApproverReq)
        {
            var approve = Get(verifyApproverReq.Id);
            if (approve == null)
            {
                throw  new Exception("加签审批失败，没能找打对应的加签人信息");
            }
            Repository.Update(u => new FlowApprover()
            {
                Status = verifyApproverReq.Status,
                VerifyComment = verifyApproverReq.VerifyComment,
                VerifyDate = DateTime.Now
            }, u => u.Id == verifyApproverReq.Id);

            if (approve.ApproveType == 2)
            {
                //如果是并行或，只需要一个审批通过即可
                return Repository.IsAny(u => u.InstanceId == approve.InstanceId
                                             && u.ActivityId == approve.ActivityId && u.Status == 1);
            }

            //没有未处理的加签信息
            return !Repository.IsAny(u => u.InstanceId == approve.InstanceId
                                          && u.ActivityId == approve.ActivityId && u.Status == 0);
        }
        
        public FlowApproverApp(ISqlSugarClient client, IAuth auth) : base(client, auth)
        {
        }
    }
}