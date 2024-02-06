using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    public class FlowSchemeApp :BaseStringApp<FlowScheme,OpenAuthDBContext>
    {
        public void Add(FlowScheme flowScheme)
        {
            if (Repository.Any(u => u.SchemeName == flowScheme.SchemeName))
            {
                throw new Exception("流程名称已经存在");
            }
            
            var user = _auth.GetCurrentUser().User;
            flowScheme.CreateUserId = user.Id;
            flowScheme.CreateUserName = user.Name;
            Repository.Add(flowScheme);
        }

        public FlowScheme FindByCode(string code)
        {
            return Repository.FirstOrDefault(u => u.SchemeCode == code);
        }

        public void Update(FlowScheme flowScheme)
        {
            if (Repository.Any(u => u.SchemeName == flowScheme.SchemeName && u.Id != flowScheme.Id))
            {
                throw new Exception("流程名称已经存在");
            }
            
            UnitWork.Update<FlowScheme>(u => u.Id == flowScheme.Id, u => new FlowScheme
            {
                SchemeContent = flowScheme.SchemeContent,
                SchemeName = flowScheme.SchemeName,
                ModifyDate = DateTime.Now,
                FrmId = flowScheme.FrmId,
                FrmType = flowScheme.FrmType,
                Disabled = flowScheme.Disabled,
                Description = flowScheme.Description,
                OrgId = flowScheme.OrgId
            });
        }

        public async Task<TableData> Load(QueryFlowSchemeListReq request)
        {
            var result = new TableData();
            var objs = GetDataPrivilege("u");
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.SchemeName.Contains(request.key) || u.Id.Contains(request.key));
            }

            result.data = await objs.OrderByDescending(u => u.CreateDate)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).ToListAsync();
            result.count = await objs.CountAsync();
            return result;
        }

        public FlowSchemeApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<FlowScheme,OpenAuthDBContext> repository,IAuth auth) : base(unitWork, repository, auth)
        {
        }
    }
}
