using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Domain.Service
{
    /// <summary>
    /// 领域服务
    /// <para>资源管理领域</para>
    /// </summary>
    public class ResManagerService
    {
        private IResourceRepository _repository;
        private readonly ICategoryRepository _categoryRepository;
        private IRelevanceRepository _relevanceRepository;
        private AuthoriseFactory _factory;

        public ResManagerService(IResourceRepository repository,
            ICategoryRepository categoryRepository,
            IRelevanceRepository relevanceRepository,
            AuthoriseFactory authoriseService)
        {
            _repository = repository;
            _categoryRepository = categoryRepository;
            _relevanceRepository = relevanceRepository;
            _factory = authoriseService;
        }

        public int GetResourceCntInOrg(Guid orgId)
        {
            if (orgId == Guid.Empty)
            {
                return _repository.Find(null).Count();
            }
            else
            {
                return _repository.GetResourceCntInOrgs(_categoryRepository.GetSubIds(orgId));
            }
        }

        public List<Resource> LoadAll()
        {
            return _repository.Find(null).ToList();
        }

        /// <summary>
        /// 加载用户一个节点下面的一个或全部Resources
        /// </summary>
        public dynamic Load(string username, Guid categoryId, int page, int rows)
        {
            var service = _factory.Create(username);
            if (!service.GetResourcesQuery().Any()) //用户没有任何资源
            {
                return new
                {
                    total = 0,
                    page = 0,
                    records = 0
                };
            }
            var subIds = _categoryRepository.GetSubIds(categoryId);


            var query = service.GetResourcesQuery().Where(u => categoryId == Guid.Empty ||
            (u.CategoryId != null && subIds.Contains(u.CategoryId.Value)));
            int total = query.Count();

            if (total <= 0)
                return new
                {
                    total = 0,
                    page = 0,
                    records = 0
                };

            var listVms = new List<dynamic>();
            var resources = query.OrderBy(u => u.SortNo).Skip((page - 1) * rows).Take(rows);
            foreach (var element in resources)
            {
                var accessed = _categoryRepository.FindSingle(u => u.Id == element.CategoryId);
                listVms.Add(new
                {
                    element.Id,
                    element.Name,
                    element.Key,
                    element.SortNo,
                    element.CategoryId,
                    element.Status,
                    CategoryName = accessed != null ? accessed.Name : ""
                });
            }

            return new
            {
                records = total,
                total = (int)Math.Ceiling((double)total / rows),
                rows = listVms,
                page = page
            };
        }



        public Resource Find(Guid id)
        {
            var resource = _repository.FindSingle(u => u.Id == id);
            if (resource == null) return new Resource();

            return resource;
        }

        public void Delete(Guid[] ids)
        {
            _repository.Delete(u => ids.Contains(u.Id));
        }

        public void AddOrUpdate(Resource resource)
        {
            if (resource.Id == Guid.Empty)
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
        public List<dynamic> LoadWithAccess(string username, string accessType, Guid firstId, Guid cId)
        {
            var listVms = new List<dynamic>();
            var service = _factory.Create(username);
            if (!service.GetResourcesQuery().Any()) //用户没有任何资源
            {
                return listVms;
            }

            var subIds = _categoryRepository.GetSubIds(cId);
            var query = service.GetResourcesQuery().Where(u => cId == Guid.Empty || (u.CategoryId != null && subIds.Contains(u.CategoryId.Value)));

            foreach (var element in query)
            {
                var accessed = _relevanceRepository.FindSingle(u => u.Key == accessType
                    && u.FirstId == firstId && u.SecondId == element.Id);
                listVms.Add(new
                {
                    Id = element.Id,
                    Name = element.Name,
                    Checked = accessed != null,
                    Description = element.Description,
                    Key = element.Key,
                    Status = element.Status
                });
            }
            return listVms;
        }

    }
}