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
    public class SysPrinterPlanApp : BaseStringApp<SysPrinterPlan, OpenAuthDBContext>
    {
        /// <summary>
        /// 加载列表
        /// </summary>
        public async Task<TableData> Load(QuerySysPrinterPlanListReq request)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            var columnFields = loginContext.GetTableColumns("SysPrinterPlan");
            if (columnFields == null || columnFields.Count == 0)
            {
                throw new Exception("请在代码生成界面配置SysPrinterPlan表的字段属性");
            }

            var result = new TableData();
            var objs = GetDataPrivilege("u");
            if (!string.IsNullOrEmpty(request.key))
            {
                //增加筛选条件,如：
                objs = objs.Where(u => u.Name.Contains(request.key));
            }

            var propertyStr = string.Join(',', columnFields.Select(u => u.ColumnName));
            result.columnFields = columnFields;
            result.data = objs.OrderBy(u => u.Id)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).Select($"new ({propertyStr})");
            result.count = await objs.CountAsync();
            return result;
        }

        public void Add(AddOrUpdateSysPrinterPlanReq obj)
        {
            //程序类型取入口应用的名称，可以根据自己需要调整
            var addObj = obj.MapTo<SysPrinterPlan>();
            //addObj.Time = DateTime.Now;
            Repository.Add(addObj);
        }

        public void Update(AddOrUpdateSysPrinterPlanReq obj)
        {
            UnitWork.Update<SysPrinterPlan>(u => u.Id == obj.Id, u => new SysPrinterPlan
            {
                Name = obj.Name,
                SourceSql = obj.SourceSql,
                PlanContent = obj.PlanContent
            });
        }

        public SysPrinterPlanApp(IUnitWork<OpenAuthDBContext> unitWork,
            IRepository<SysPrinterPlan, OpenAuthDBContext> repository, IAuth auth) : base(unitWork, repository, auth)
        {
        }
    }
}