using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 分类管理
    /// </summary>
    public class ResourceApp:BaseStringApp<Resource,OpenAuthDBContext>
    {
        private RevelanceManagerApp _revelanceApp;

        public void Add(AddOrUpdateResReq resource)
        {
            var obj = resource.MapTo<Resource>();
            CaculateCascade(obj);
            obj.CreateTime = DateTime.Now;
            var user = _auth.GetCurrentUser().User;
            obj.CreateUserId = user.Id;
            obj.CreateUserName = user.Name;
            Repository.Add(obj);
        }

        public void Update(AddOrUpdateResReq obj)
        {
            var user = _auth.GetCurrentUser().User;
            UnitWork.Update<Resource>(u => u.Id == obj.Id, u => new Resource
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
            });
        }

        public IEnumerable<Resource> LoadForRole(string appId, string roleId)
        {
            var elementIds = _revelanceApp.Get(Define.ROLERESOURCE, true, roleId);
            return UnitWork.Find<Resource>(u => elementIds.Contains(u.Id) && (appId == null || appId =="" || u.AppId == appId));
        }
        
        public async Task<TableData> Load(QueryResourcesReq request)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            //兼容以前功能，仅为开源版提供功能，后续可以只用GetTableColumns
            var properties = loginContext.GetProperties("Resource");
            if (properties == null || properties.Count == 0)
            {
                throw new Exception("当前登录用户没有访问该模块字段的权限，请联系管理员配置");
            }

            var columnFields = loginContext.GetTableColumns("Resource");
            //if (columnFields == null || columnFields.Count == 0)
            //{
            //    throw new Exception("请在代码生成界面配置Resource表的字段属性");
            //}


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

            var propertyStr = string.Join(',', columnFields.Select(u => u.ColumnName));
            result.columnHeaders = properties;
            result.columnFields = columnFields;
            result.data = resources.OrderBy(u => u.TypeId)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).Select($"new ({propertyStr})");
            result.count = resources.Count();
            return result;
        }

        public ResourceApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<Resource,OpenAuthDBContext> repository
        ,RevelanceManagerApp app,IAuth auth) : base(unitWork, repository, auth)
        {
            _revelanceApp = app;
        }
    }
}