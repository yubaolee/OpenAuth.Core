using System;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class FrmLeaveReqApp : BaseApp<FrmLeaveReq>
    {
        private RevelanceManagerApp _revelanceApp;

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QueryFrmLeaveReqListReq request)
        {
             return new TableData
            {
                count = Repository.GetCount(null),
                data = Repository.Find(request.page, request.limit, "Id desc")
            };
        }

        public void Add(FrmLeaveReq obj)
        {
            Repository.Add(obj);
        }
        
        public void Update(FrmLeaveReq obj)
        {
            UnitWork.Update<FrmLeaveReq>(u => u.Id == obj.Id, u => new FrmLeaveReq
            {
               //todo:要修改的字段赋值
            });

        }

        public FrmLeaveReqApp(IUnitWork unitWork, IRepository<FrmLeaveReq> repository,
            RevelanceManagerApp app) : base(unitWork, repository)
        {
            _revelanceApp = app;
        }
    }
}