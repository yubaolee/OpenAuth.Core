using System;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    public class FlowSchemeApp :BaseApp<FlowScheme>
    {
        
        public void Add(FlowScheme flowScheme)
        {
            Repository.Add(flowScheme);
        }

        public FlowScheme FindByCode(string code)
        {
            return Repository.FindSingle(u => u.SchemeCode == code);
        }

        public void Update(FlowScheme flowScheme)
        {
            UnitWork.Update<FlowScheme>(u => u.Id == flowScheme.Id, u => new FlowScheme
            {
                SchemeContent = flowScheme.SchemeContent,
                SchemeName = flowScheme.SchemeName,
                ModifyDate = DateTime.Now,
                FrmId = flowScheme.FrmId,
                FrmType = flowScheme.FrmType,
                Disabled = flowScheme.Disabled,
                Description = flowScheme.Description
            });
        }

        public TableData Load(QueryFlowSchemeListReq request)
        {
            return new TableData
            {
                count = Repository.GetCount(null),
                data = Repository.Find(request.page, request.limit, "CreateDate desc")
            };
        }

        public FlowSchemeApp(IUnitWork unitWork, IRepository<FlowScheme> repository,IAuth auth) : base(unitWork, repository, auth)
        {
        }
    }
}
