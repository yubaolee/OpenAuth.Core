using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IModuleRepository :IRepository<Module>
    {
        IEnumerable<Module> LoadModules(int pageindex, int pagesize);

        IEnumerable<Module> LoadInOrgs(params string[] orgId);
        int GetModuleCntInOrgs(params string[] orgIds);
        IEnumerable<Module> LoadInOrgs(int pageindex, int pagesize, params string[] orgIds);

        
        void Delete(string id);

    }
}