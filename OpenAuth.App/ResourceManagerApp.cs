
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;

namespace OpenAuth.App
{
    public class ResourceManagerApp
    {
        private IResourceRepository _repository;
        private readonly ICategoryRepository _categoryRepository;

        public ResourceManagerApp(IResourceRepository repository,
            ICategoryRepository categoryRepository)
        {
            _repository = repository;
            _categoryRepository = categoryRepository;
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

       
    }
}