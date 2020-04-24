using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 分类管理
    /// </summary>
    public class ResourceApp:BaseApp<Resource>
    {
        private RevelanceManagerApp _revelanceApp;

        public void Add(AddOrUpdateResReq resource)
        {
            var obj = resource.MapTo<Resource>();
            ChangeModuleCascade(obj);
            obj.CreateTime = DateTime.Now;
            var user = _auth.GetCurrentUser().User;
            obj.CreateUserId = user.Id;
            obj.CreateUserName = user.Name;
            Repository.Add(obj);
        }

        public void Update(AddOrUpdateResReq obj)
        {
            var user = _auth.GetCurrentUser().User;
            UnitWork.Update<Category>(u => u.Id == obj.Id, u => new Category
            {
                TypeId = obj.TypeId,
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
        
        public TableData Load(QueryResourcesReq request)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            var properties = loginContext.GetProperties("Resource");

            if (properties == null || properties.Count == 0)
            {
                throw new Exception("当前登录用户没有访问该模块字段的权限，请联系管理员配置");
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

            var propertyStr = string.Join(',', properties.Select(u => u.Key));
            result.columnHeaders = properties;
            result.data = resources.OrderBy(u => u.TypeId)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).Select($"new ({propertyStr})");
            result.count = resources.Count();
            return result;
        }

        public ResourceApp(IUnitWork unitWork, IRepository<Resource> repository
        ,RevelanceManagerApp app,IAuth auth) : base(unitWork, repository, auth)
        {
            _revelanceApp = app;
        }
    }
}