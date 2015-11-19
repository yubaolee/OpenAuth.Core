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

        public RoleManagerApp(IRoleRepository repository,
            IOrgRepository orgRepository)
        {
            _repository = repository;
            _orgRepository = orgRepository;
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
            IEnumerable<Role> roles;
            int total = 0;
            if (orgId == 0)
            {
                roles = _repository.LoadRoles(pageindex, pagesize);
                total = _repository.GetCount();
            }
            else
            {
                roles = _repository.LoadInOrgs(pageindex, pagesize,GetSubOrgIds(orgId));
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
            return  _repository.FindSingle(u => u.Id == id);
           
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }

        public void AddOrUpdate(Role view)
        {
            Role Role = view;
            if (Role.Id == 0)
            {
                Role.CreateTime = DateTime.Now;
                _repository.Add(Role);
            }
            else
            {
                _repository.Update(Role);
            }

        }

       
    }
}