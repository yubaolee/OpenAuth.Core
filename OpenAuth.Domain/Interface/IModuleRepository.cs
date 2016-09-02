using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IModuleRepository :IRepository<Module>
    {
        IEnumerable<Module> LoadModules(int pageindex, int pagesize);

        IEnumerable<Module> LoadInOrgs(params Guid[] orgId);
        int GetModuleCntInOrgs(params Guid[] orgIds);
        IEnumerable<Module> LoadInOrgs(int pageindex, int pagesize, params Guid[] orgIds);

        
        void Delete(Guid id);

    }
}