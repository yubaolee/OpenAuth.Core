
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App.ViewModel;

namespace OpenAuth.App
{
    public class ResourceManagerApp
    {
        private IResourceRepository _repository;
        private readonly ICategoryRepository _categoryRepository;
        private IRelevanceRepository _relevanceRepository;

        public ResourceManagerApp(IResourceRepository repository,
            ICategoryRepository categoryRepository,
            IRelevanceRepository relevanceRepository)
        {
            _repository = repository;
            _categoryRepository = categoryRepository;
            _relevanceRepository = relevanceRepository;
        }

        public int GetResourceCntInOrg(int orgId)
        {
            if (orgId == 0)
            {
                return _repository.Find(null).Count();
            }
            else
            {
                return _repository.GetResourceCntInOrgs(GetSubOrgIds(orgId));
            }
        }
        
        public List<Resource> LoadAll()
        {
            return _repository.Find(null).ToList();
        }

        /// <summary>
        /// 加载一个节点下面的一个或全部Resources
        /// </summary>
        public dynamic Load(int categoryId, int pageindex, int pagesize)
        {
            IEnumerable<Resource> Resources;
            int total = 0;
            if (categoryId == 0)
            {
                Resources = _repository.LoadResources(pageindex, pagesize);
                total = _repository.GetCount();
            }
            else
            {
                Resources = _repository.LoadInOrgs(pageindex, pagesize,GetSubOrgIds(categoryId));
                total = _repository.GetResourceCntInOrgs(categoryId);
            }

            return new 
            {
                total = total,
                list = Resources,
                pageCurrent = pageindex
            };
        }

        /// <summary>
        /// 获取当前节点的所有下级节点
        /// </summary>
        private int[] GetSubOrgIds(int orgId)
        {
            var org = _categoryRepository.FindSingle(u => u.Id == orgId);
            var orgs = _categoryRepository.Find(u => u.CascadeId.Contains(org.CascadeId)).Select(u => u.Id).ToArray();
            return orgs;
        }

        public Resource Find(int id)
        {
            var resource = _repository.FindSingle(u => u.Id == id);
            if (resource == null) return new Resource();

            return resource;
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }

        public void AddOrUpdate(Resource model)
        {
            Resource resource  = new  Resource();
            model.CopyTo(resource);
            
            if (resource.Id == 0)
            {
                _repository.Add(resource);
            }
            else
            {
                _repository.Update(resource);
            }
           
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
        public List<ResourceVM> LoadWithAccess(string accessType, int firstId, int cId)
        {
            var listVms = new List<ResourceVM>();
            if (cId == 0) return listVms;

            foreach (var element in _repository.LoadInOrgs(cId))
            {
                var accessed = _relevanceRepository.FindSingle(u => u.Key == accessType
                    && u.FirstId == firstId && u.SecondId == element.Id);
                listVms.Add(new ResourceVM
                {
                    Id = element.Id,
                    Name = element.Name,
                    IsBelongUser =  accessed != null,
                    Description = element.Description,
                    Key = element.Key,
                    Status = element.Status
                });
            }
            return listVms;
        }

        /// <summary>
        /// 为用户分配资源
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="resIds">资源ID数组</param>
        public void AssignResForUser(int userId, int[] resIds)
        {
            _relevanceRepository.DeleteBy("UserResource", resIds);
            _relevanceRepository.AddRelevance("UserResource", resIds.ToLookup(u => userId));
        }

        /// <summary>
        /// 为角色分配资源
        /// </summary>
        /// <param name="roleId">角色ID</param>
        /// <param name="resIds">资源ID数组</param>
        public void AssignResForRole(int roleId, int[] resIds)
        {
            _relevanceRepository.DeleteBy("RoleResource", resIds);
            _relevanceRepository.AddRelevance("RoleResource", resIds.ToLookup(u => roleId));
        }
    }
}