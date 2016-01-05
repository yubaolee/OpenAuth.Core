using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IModuleRepository :IRepository<Module>
    {
        IEnumerable<Module> LoadModules(int pageindex, int pagesize);

        IEnumerable<Module> LoadInOrgs(params int[] orgId);
        int GetModuleCntInOrgs(params int[] orgIds);
        IEnumerable<Module> LoadInOrgs(int pageindex, int pagesize, params int[] orgIds);

        
        void Delete(int id);

    }
}