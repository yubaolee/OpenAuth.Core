
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.App
{
    public class ModuleManagerApp
    {
        private IModuleRepository _repository;
        private IOrgRepository _orgRepository;

        public ModuleManagerApp(IModuleRepository repository,
            IOrgRepository orgRepository)
        {
            _repository = repository;
            _orgRepository = orgRepository;
        }

        public int GetModuleCntInOrg(int orgId)
        {
            if (orgId == 0)
            {
                return _repository.Find(null).Count();
            }
            else
            {
                return _repository.GetModuleCntInOrgs(GetSubOrgIds(orgId));
            }
        }

        /// <summary>
        /// 加载一个部门及子部门全部Modules
        /// </summary>
        public dynamic Load(int orgId, int pageindex, int pagesize)
        {
            IEnumerable<Module> Modules;
            int total = 0;
            if (orgId == 0)
            {
                Modules = _repository.LoadModules(pageindex, pagesize);
                total = _repository.GetCount();
            }
            else
            {
                Modules = _repository.LoadInOrgs(pageindex, pagesize,GetSubOrgIds(orgId));
                total = _repository.GetModuleCntInOrgs(orgId);
            }

            return new 
            {
                total = total,
                list = Modules,
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

        public Module Find(int id)
        {
            var module = _repository.FindSingle(u => u.Id == id);
            if (module == null) return new Module();

            return module;
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }

        public void AddOrUpdate(Module model)
        {
            Module module = model;
            if (module.Id == 0)
            {
                _repository.Add(module);
            }
            else
            {
                _repository.Update(module);
            }
           
        }

       
    }
}