using System;
using System.Collections.Generic;
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
    /// <summary>
    /// 分类管理
    /// </summary>
    public class ResourceApp:SqlSugarBaseApp<SysResource>
    {
        private RevelanceManagerApp _revelanceApp;

        public void Add(AddOrUpdateResReq resource)
        {
            var obj = resource.MapTo<SysResource>();
            CaculateCascade(obj);
            obj.CreateTime = DateTime.Now;
            var user = _auth.GetCurrentUser().User;
            obj.CreateUserId = user.Id;
            obj.CreateUserName = user.Name;
            Repository.Insert(obj);
        }

        public void Update(AddOrUpdateResReq obj)
        {
            var user = _auth.GetCurrentUser().User;
            Repository.Update(u => new SysResource
            {
                Name = obj.Name,
                Disable = obj.Disable,
                CascadeId = obj.CascadeId,
                AppId = obj.AppId,
                AppName = obj.AppName,
                ParentId = obj.ParentId,
                ParentName = obj.ParentName,
                TypeId = obj.TypeId,
                TypeName = obj.TypeName,
                Description = obj.Description,
                UpdateTime = DateTime.Now,
                UpdateUserId = user.Id,
                UpdateUserName = user.Name
                //todo:要修改的字段赋值
            },u => u.Id == obj.Id);
        }

        public IEnumerable<SysResource> LoadForRole(string appId, string roleId)
        {
            var elementIds = _revelanceApp.Get(Define.ROLERESOURCE, true, roleId);
            return SugarClient.Queryable<SysResource>().Where(u => elementIds.Contains(u.Id) && (appId == null || appId =="" || u.AppId == appId)).ToArray();
        }
        
        public async Task<TableData> Load(QueryResourcesReq request)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            var columnFields = loginContext.GetTableColumns("Resource");
            if (columnFields == null || columnFields.Count == 0)
            {
                throw new Exception("请在代码生成界面配置Resource表的字段属性");
            }


            var result = new TableData();
            var resources = GetDataPrivilege("u");
            if (!string.IsNullOrEmpty(request.key))
            {
                resources = resources.Where(u => u.Name.Contains(request.key) || u.Id.Contains(request.key));
            }

            if (!string.IsNullOrEmpty(request.appId))
            {
                resources = resources.Where(u => u.AppId == request.appId);
            }

            var columnnames = columnFields.Select(u => u.ColumnName);
            if (SugarClient.CurrentConnectionConfig.DbType == DbType.PostgreSQL 
                || SugarClient.CurrentConnectionConfig.DbType == DbType.Oracle)
            {
                columnnames = columnFields.Select(u => "\"" + u.ColumnName +"\"");
            }
            var propertyStr = string.Join(',', columnnames);
            result.columnFields = columnFields;
            result.data = resources.OrderBy(u => u.TypeId)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).Select($"{propertyStr}").ToList();
            result.count = await resources.CountAsync();
            return result;
        }

        public ResourceApp(ISqlSugarClient client, IAuth auth, RevelanceManagerApp revelanceApp) : base(client, auth)
        {
            _revelanceApp = revelanceApp;
        }
        
    }
}