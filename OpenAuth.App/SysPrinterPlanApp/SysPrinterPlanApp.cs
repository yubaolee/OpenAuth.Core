using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Nodes;
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
        
        public async Task<TableData> Query(QueryReq request)
        {
            var result = new TableData();

            var sugarParams = new List<SugarParameter>();
            if (!string.IsNullOrEmpty(request.ParamJsonStr))
            {
                var param = JsonHelper.Instance.Deserialize<Dictionary<string, string>>(request.ParamJsonStr);
                foreach (var p in param)
                {
                    sugarParams.Add(new SugarParameter($"@{p.Key}", p.Value));
                }
            }
            
            var objs = await SugarClient.Ado.SqlQueryAsync<dynamic>(request.SourceSql,sugarParams);
            result.count = SugarClient.Ado.SqlQuery<dynamic>(request.SourceSql, sugarParams).Count;
            result.data = objs.Skip((request.page - 1) * request.limit)
                .Take(request.limit).ToList();

            return result;
        }

        public string Add(AddOrUpdateSysPrinterPlanReq obj)
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
            return addObj.Id;
        }

        public void Update(AddOrUpdateSysPrinterPlanReq obj)
        {
            Repository.Update(u => new SysPrinterPlan
            {
                Name = obj.Name,
                SourceSql = obj.SourceSql,
                PlanContent = obj.PlanContent,
                ColumnView = obj.ColumnView,
                InParamColumn = obj.InParamColumn,
                GroupBy = obj.GroupBy
            },u => u.Id == obj.Id);
        }
        
        public SysPrinterPlanApp(ISqlSugarClient client, IAuth auth) : base(client, auth)
        {
        }

        public List<DbTableInfo> GetTables()
        {
            return SugarClient.DbMaintenance.GetTableInfoList();
        }

        public List<DbColumnInfo> GetColumns(string tableViewName)
        {
            return SugarClient.DbMaintenance.GetColumnInfosByTableName(tableViewName);
        }
    }
}