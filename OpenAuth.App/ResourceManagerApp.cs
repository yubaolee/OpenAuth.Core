
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain.Service;

namespace OpenAuth.App
{
    public class ResourceManagerApp
    {
        private ResManagerService _resManagerService;

        public ResourceManagerApp(ResManagerService resManagerService)
        {
            _resManagerService = resManagerService;
        }

        public int GetResourceCntInOrg(Guid orgId)
        {
            return _resManagerService.GetResourceCntInOrg(orgId);
        }
        
        public List<Resource> LoadAll()
        {
            return _resManagerService.LoadAll();
        }

        /// <summary>
        /// 加载一个节点下面的一个或全部Resources
        /// </summary>
        public dynamic Load(string username, Guid categoryId, int pageindex, int pagesize)
        {
            return _resManagerService.Load(username, categoryId, pageindex, pagesize);
        }



        public void Delete(Guid[] ids)
        {
            _resManagerService.Delete(ids);
        }

        public void AddOrUpdate(Resource model)
        {
            Resource resource  = new  Resource();
            model.CopyTo(resource);
            _resManagerService.AddOrUpdate(resource);
           
        }

        /// <summary>
        /// 获取带有授权状态的菜单列表
        /// </summary>
        /// <param name="accessType">授权类型，当前有RoleResource/UserResource</param>
        /// <param name="firstId">
        /// 当为RoleResource时，表示RoleId
        /// 当为UserResource时，表示UserId
        /// </param>
        /// <param name="cId">分类ID</param>
        public List<dynamic> LoadWithAccess(string username, string accessType, Guid firstId, Guid cId)
        {
            return _resManagerService.LoadWithAccess(username, accessType, firstId, cId);
        }

    }
}