using System;
using System.Linq;
using System.Threading.Tasks;
using Infrastructure;
using Microsoft.EntityFrameworkCore;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class FlowApproverApp : BaseTreeApp<FlowApprover,OpenAuthDBContext>
    {

        /// <summary>
        /// 加载列表
        /// </summary>
        public async Task<TableData> Load(QueryFlowApproverListReq request)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
            throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }
        
           
            var result = new TableData();
            var objs = GetDataPrivilege("u");
            if (!string.IsNullOrEmpty(request.key))
            {
            //增加筛选条件,如：
            //objs = objs.Where(u => u.Name.Contains(request.key));
            }

            
          
            result.data = objs.OrderBy(u => u.Id)
            .Skip((request.page - 1) * request.limit)
            .Take(request.limit);
            result.count =await objs.CountAsync();
            return result;
        }

        public void Add(AddOrUpdateFlowApproverReq obj)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }
            
            //程序类型取入口应用的名称，可以根据自己需要调整
            var addObj = obj.MapTo<FlowApprover>();
            CaculateCascade(addObj);
            addObj.CreateDate = DateTime.Now;
            addObj.CreateUserId = loginContext.User.Id;
            addObj.CreateUserName = loginContext.User.Name;
            addObj.Name = addObj.Id;
            Repository.Add(addObj);
        }
        
        public void Update(AddOrUpdateFlowApproverReq obj)
        {
            UnitWork.Update<FlowApprover>(u => u.Id == obj.Id, u => new FlowApprover
            {
               //todo:要修改的字段赋值
            });

        }

        public FlowApproverApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<FlowApprover,OpenAuthDBContext> repository, IAuth auth) : base(unitWork, repository, auth)
        {
        }
    }
}