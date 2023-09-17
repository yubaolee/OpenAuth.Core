using System;
using System.Linq;
using System.Threading.Tasks;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using SqlSugar;


namespace OpenAuth.App
{
    public class SysPrinterPlanApp : SqlSugarBaseApp<SysPrinterPlan>
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
            result.data = objs.OrderByDescending(u => u.CreateTime)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).Select($"{propertyStr}").ToList();
            result.count = await objs.CountAsync();
            return result;
        }

        public void Add(AddOrUpdateSysPrinterPlanReq obj)
        {
            //程序类型取入口应用的名称，可以根据自己需要调整
            var addObj = obj.MapTo<SysPrinterPlan>();
            if (addObj.KeyIsNull())
            {
                addObj.GenerateDefaultKeyVal();
            }
            addObj.CreateTime = DateTime.Now;
            addObj.CreateUser = _auth.GetUserName();
            Repository.Insert(addObj);
        }

        public void Update(AddOrUpdateSysPrinterPlanReq obj)
        {
            Repository.Update(u => new SysPrinterPlan
            {
                Name = obj.Name,
                SourceSql = obj.SourceSql,
                PlanContent = obj.PlanContent
            },u => u.Id == obj.Id);
        }
        
        public SysPrinterPlanApp(ISqlSugarClient client, IAuth auth) : base(client, auth)
        {
        }

    }
}