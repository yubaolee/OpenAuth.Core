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
    public class FrmLeaveReqApp : BaseStringApp<FrmLeaveReq,OpenAuthDBContext>, ICustomerForm
    {
        private RevelanceManagerApp _revelanceApp;

        /// <summary>
        /// 加载列表
        /// </summary>
        public async Task<TableData> Load(QueryFrmLeaveReqListReq request)
        {
             return new TableData
            {
                count = await Repository.CountAsync(null),
                data = await Repository.Find(request.page, request.limit, "Id desc").ToListAsync()
            };
        }

        public void Add(FrmLeaveReq obj)
        {
            Repository.Add(obj);
        }
        
        public FrmLeaveReqApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<FrmLeaveReq,OpenAuthDBContext> repository,
            RevelanceManagerApp app,IAuth auth) : base(unitWork, repository, auth)
        {
            _revelanceApp = app;
        }

        public void Add(string flowInstanceId, string frmData)
        {
            var req = JsonHelper.Instance.Deserialize<FrmLeaveReq>(frmData);
            req.FlowInstanceId = flowInstanceId;
            Add(req);
        }

        public void Update(string flowInstanceId, string frmData)
        {
            var req = JsonHelper.Instance.Deserialize<FrmLeaveReq>(frmData);
            UnitWork.Update<FrmLeaveReq>(u => u.FlowInstanceId == flowInstanceId, u => new FrmLeaveReq
            {
                UserName = req.UserName,
                RequestComment = req.RequestComment,
                RequestType = req.RequestType
                //补充其他需要更新的字段
            });
        }
    }
}