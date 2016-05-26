using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;

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

        public int GetRoleCntInOrg(int orgId)
        {
            if (orgId == 0)
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
        public dynamic Load(int orgId, int pageindex, int pagesize)
        {
            if (pageindex < 1) pageindex = 1; //TODO:如果列表为空新增加一个用户后，前端会传一个0过来，奇怪？？
            IEnumerable<Role> roles;
            int total = 0;
            if (orgId == 0)
            {
                roles = _repository.LoadRoles(pageindex, pagesize);
                total = _repository.GetCount();
            }
            else
            {
                roles = _repository.LoadInOrgs(pageindex, pagesize, GetSubOrgIds(orgId));
                total = _repository.GetRoleCntInOrgs(orgId);
            }

            return new
            {
                total = total,
                list = roles,
                pageCurrent = pageindex
            };
        }

        /// <summary>
        /// 获取当前组织的所有下级组织
        /// </summary>
        private int[] GetSubOrgIds(int orgId)
        {
            var org = _orgRepository.FindSingle(u => u.Id == orgId);
            var orgs = _orgRepository.Find(u => u.CascadeId.Contains(org.CascadeId)).Select(u => u.Id).ToArray();
            return orgs;
        }

        public Role Find(int id)
        {
            var role = _repository.FindSingle(u => u.Id == id);
            if (role == null) role = new Role();
            return role;
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }

        public void AddOrUpdate(Role role)
        {
            if (role.Id == 0)
            {
                role.CreateTime = DateTime.Now;
                _repository.Add(role);
            }
            else
            {
                _repository.Update(role);
            }
        }

        public List<RoleVM> LoadForOrgAndUser(int orgId, int userId)
        {
            var allorgs = GetSubOrgIds(orgId);
            var roleIds = _repository.Find(u => orgId == 0 || allorgs.Contains(u.OrgId)).ToList();
            var rolevms = new List<RoleVM>();
            foreach (var role in roleIds)
            {
                RoleVM rolevm = role;
                rolevm.IsBelongUser = (_relevanceRepository.FindSingle(u => u.SecondId == role.Id
                                                                            && u.FirstId == userId
                                                                            && u.Key == "UserRole")
                                       != null);
                rolevms.Add(rolevm);
            }
            return rolevms;
        }

        public void AccessRole(int userId, int[] roleIds)
        {
            _relevanceRepository.AddRelevance("UserRole", roleIds.ToLookup(roleId => userId));
        }

        public void DelAccessRole(int userId, int[] roleids)
        {
            _relevanceRepository.DeleteBy("UserRole", roleids.ToLookup(roleId => userId));
        }
    }
}