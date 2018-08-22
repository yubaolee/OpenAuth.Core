using System;
using System.Collections.Generic;
using System.Linq;
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

        public void Add(Resource resource)
        {
            if (string.IsNullOrEmpty(resource.Id))
            {
                resource.Id = Guid.NewGuid().ToString();
            }
            Repository.Add(resource);
        }

        public void Update(Resource resource)
        {
            Repository.Update(resource);
        }

        public IEnumerable<Resource> LoadForUser(string appId, string userId)
        {
            var elementIds = _revelanceApp.Get(Define.USERRESOURCE, true, userId);
            return UnitWork.Find<Resource>(u => elementIds.Contains(u.Id) && (appId == "" || u.AppId == appId));
        }

        public IEnumerable<Resource> LoadForRole(string appId, string userId)
        {
            var elementIds = _revelanceApp.Get(Define.ROLERESOURCE, true, userId);
            return UnitWork.Find<Resource>(u => elementIds.Contains(u.Id) && (appId =="" || u.AppId == appId));
        }



        public TableData Load(QueryResourcesReq request)
        {
            var result = new TableData();
            var resources =  UnitWork.Find<Resource>(null) ;
            if (!string.IsNullOrEmpty(request.key))
            {
                resources = resources.Where(u => u.Name.Contains(request.key) || u.Id.Contains(request.key));
            }

            if (!string.IsNullOrEmpty(request.appId))
            {
                resources = resources.Where(u => u.AppId == request.appId);
            }


            result.data = resources.OrderBy(u => u.TypeId)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).ToList();
            result.count = resources.Count();
            return result;
        }

        public ResourceApp(IUnitWork unitWork, IRepository<Resource> repository
        ,RevelanceManagerApp app) : base(unitWork, repository)
        {
            _revelanceApp = app;
        }
    }
}