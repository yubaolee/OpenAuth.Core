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
        private AuthoriseService _authoriseService;

        public ResManagerService(IResourceRepository repository,
            ICategoryRepository categoryRepository,
            IRelevanceRepository relevanceRepository,
            AuthoriseService authoriseService)
        {
            _repository = repository;
            _categoryRepository = categoryRepository;
            _relevanceRepository = relevanceRepository;
            _authoriseService = authoriseService;
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
        /// 加载用户一个节点下面的一个或全部Resources
        /// </summary>
        public dynamic Load(string username, int categoryId, int pageindex, int pagesize)
        {
            _authoriseService.LoadAuthControls(username);
            if (_authoriseService.Resources.Count == 0) //用户没有任何资源
            {
                return new
                {
                    total = 0,
                    pageCurrent = pageindex
                };
            }
            var subIds = GetSubOrgIds(categoryId);
            var query = _authoriseService.Resources.Where(u => categoryId == 0 || subIds.Contains(u.CategoryId));
            var Resources = query.Skip((pageindex - 1) * pagesize).Take(pagesize);
            int total = query.Count();

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
            if (orgId == 0)
            {
                return _categoryRepository.Find(null).Select(u => u.Id).ToArray();
            }
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

        public void AddOrUpdate(Resource resource)
        {
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
        public List<dynamic> LoadWithAccess(string username, string accessType, int firstId, int cId)
        {
            var listVms = new List<dynamic>();
            _authoriseService.LoadAuthControls(username);
            if (_authoriseService.Resources.Count == 0) //用户没有任何资源
            {
                return listVms;
            }

            var subIds = GetSubOrgIds(cId);
            var query = _authoriseService.Resources.Where(u => cId == 0 || subIds.Contains(u.CategoryId));

            foreach (var element in query)
            {
                var accessed = _relevanceRepository.FindSingle(u => u.Key == accessType
                    && u.FirstId == firstId && u.SecondId == element.Id);
                listVms.Add(new
                {
                    Id = element.Id,
                    Name = element.Name,
                    IsBelongUser = accessed != null,
                    Description = element.Description,
                    Key = element.Key,
                    Status = element.Status
                });
            }
            return listVms;
        }

    }
}