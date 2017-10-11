using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Repository
{
    public class ModuleRepository :BaseRepository<Module>, IModuleRepository
    {
        public IEnumerable<Module> LoadModules(int pageindex, int pagesize)
        {
            return Context.Modules.OrderBy(u => u.Id).Skip((pageindex - 1) * pagesize).Take(pagesize);
        }

        public int GetRoleCntInOrgs(params string[] orgIds)
        {
            return LoadInOrgs(orgIds).Count();
        }

        public int GetModuleCntInOrgs(params string[] orgIds)
        {
            return LoadInOrgs(orgIds).Count();
        }


        public IEnumerable<Module> LoadInOrgs(int pageindex, int pagesize, params string[] orgIds)
        {
            return LoadInOrgs(orgIds).OrderBy(u => u.Id).Skip((pageindex - 1) * pagesize).Take(pagesize);
        }

        public void Delete(string id)
        {
            Delete(u =>u.Id == id);
        }

        public IEnumerable<Module> LoadInOrgs(params string[] orgId)
        {
            var result = from role in Context.Modules.Where(u =>u.ParentId != null && orgId.Contains(u.ParentId)) select role;
                        
            return result;

        }
    }
}
