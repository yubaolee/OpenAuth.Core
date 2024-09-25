using System;
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
            if (string.IsNullOrEmpty(obj.Id))
            {
                obj.Id = Guid.NewGuid().ToString();
            }

            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            var addObj = obj.MapTo<FlowApprover>();
            CaculateCascade(addObj);
            addObj.CreateDate = DateTime.Now;
            addObj.CreateUserId = loginContext.User.Id;
            addObj.CreateUserName = loginContext.User.Name;
            addObj.Name = addObj.Id;

            Repository.Insert(addObj);
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