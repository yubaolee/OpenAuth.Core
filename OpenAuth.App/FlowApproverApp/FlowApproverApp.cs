using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using SqlSugar;


namespace OpenAuth.App
{
    public class FlowApproverApp : SqlSugarBaseApp<FlowApprover>
    {
        public void Add(AddApproverReq obj)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            var objs =new  List<FlowApprover>();
            foreach (var approver in obj.Approvers)
            {
                var addobj = approver.MapTo<FlowApprover>();
                if (string.IsNullOrEmpty(addobj.Id))
                {
                    addobj.Id = Guid.NewGuid().ToString();
                }
                
                CaculateCascade(addobj);
                addobj.CreateDate = DateTime.Now;
                addobj.CreateUserId = loginContext.User.Id;
                addobj.CreateUserName = loginContext.User.Name;
                addobj.Name = addobj.Id;
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
        
        public FlowApproverApp(ISqlSugarClient client, IAuth auth) : base(client, auth)
        {
        }
    }
}