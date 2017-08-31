using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using Newtonsoft.Json.Linq;

namespace OpenAuth.App
{
    public class RoleManagerApp
    {
        private IRoleRepository _repository;
        private IOrgRepository _orgRepository;
        private IRelevanceRepository _relevanceRepository;

        public RoleManagerApp(IRoleRepository repository,
            IOrgRepository orgRepository,
            IRelevanceRepository relevanceRepository)
        {
            _repository = repository;
            _orgRepository = orgRepository;
            _relevanceRepository = relevanceRepository;
        }

        public int GetRoleCntInOrg(Guid orgId)
        {
            if (orgId == Guid.Empty)
            {
                return _repository.Find(null).Count();
            }
            else
            {
                return _repository.GetRoleCntInOrgs(GetSubOrgIds(orgId));
            }
        }

        /// <summary>
        /// 加载一个部门及子部门全部Roles
        /// </summary>
        public GridData Load(Guid orgId, int pageindex, int pagesize)
        {
            if (pageindex < 1) pageindex = 1; //TODO:如果列表为空新增加一个用户后，前端会传一个0过来，奇怪？？
            IEnumerable<Role> roles;
            int total = 0;
            if (orgId == Guid.Empty)
            {
                roles = _repository.LoadRoles(pageindex, pagesize);
                total = _repository.GetCount();
            }
            else
            {
                roles = _repository.LoadInOrgs(pageindex, pagesize, GetSubOrgIds(orgId));
                total = _repository.GetRoleCntInOrgs(orgId);
            }

            var rolevms = new List<RoleVM>();
            foreach (var role in roles)
            {
                RoleVM rolevm = role;
                var orgs = _orgRepository.LoadByRole(role.Id);
                rolevm.Organizations = string.Join(",", orgs.Select(u => u.Name).ToList());
                rolevm.OrganizationIds = string.Join(",", orgs.Select(u => u.Id).ToList());
                rolevms.Add(rolevm);
            }

            var result = new GridData
            {
                count = total,
                total = (int)Math.Ceiling((double)total/pagesize),
                data = rolevms.ToList(),
                page = pageindex
            };

            return result;
        }

        /// <summary>
        /// 获取当前组织的所有下级组织
        /// </summary>
        private Guid[] GetSubOrgIds(Guid orgId)
        {
            var orgs = _orgRepository.GetSubOrgs(orgId).Select(u => u.Id).ToArray();
            return orgs;
        }

        public Role Find(Guid id)
        {
            var role = _repository.FindSingle(u => u.Id == id);
            if (role == null) role = new Role();
            return role;
        }

        public void Delete(Guid id)
        {
            _repository.Delete(id);
        }

        public void AddOrUpdate(JObject obj)
        {
            var role = obj.ToObject<Role>();
            if (role.Id == Guid.Empty)
            {
                role.CreateTime = DateTime.Now;
                _repository.Add(role);
            }
            else
            {
                _repository.Update(role);
            }

            Guid[] orgIds = obj["OrganizationIds"].ToString().Split(',').Select(id => Guid.Parse(id)).ToArray();

            _relevanceRepository.DeleteBy("RoleOrg", role.Id);
            _relevanceRepository.AddRelevance("RoleOrg", orgIds.ToLookup(u => role.Id));
        }

        public List<Role> LoadForUser(Guid userId)
        {
            return _repository.LoadForUser(userId).ToList();
        }

        public List<RoleVM> LoadForOrgAndUser(Guid orgId, Guid userId)
        {
            var userroles = LoadForUser(userId);
            var orgroles = _repository.LoadInOrgs(GetSubOrgIds(orgId)).ToList();

            var rolevms = new List<RoleVM>();
            foreach (var role in orgroles)
            {
                RoleVM rolevm = role;
                rolevm.Checked = userroles.Any(u => u.Id == role.Id);
                var orgs = _orgRepository.LoadByRole(role.Id);
                rolevm.Organizations = string.Join(",", orgs.Select(u => u.Name).ToList());
                rolevm.OrganizationIds = string.Join(",", orgs.Select(u => u.Id).ToList());
                rolevms.Add(rolevm);
            }
            return rolevms;
        }

        public List<Guid> GetUsersInRole(string ruleName)
        {
            var role = _repository.FindSingle(u => u.Name == ruleName);
            if (role == null) return null;

            return _relevanceRepository.Find(u => u.Key == "UserRole" 
                       && u.SecondId == role.Id).Select(u => u.FirstId).ToList();
        }
    }
}