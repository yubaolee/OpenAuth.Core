using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IResourceRepository :IRepository<Resource>
    {
        IEnumerable<Resource> LoadResources(int pageindex, int pagesize);

        IEnumerable<Resource> LoadInOrgs(params int[] orgId);
        int GetResourceCntInOrgs(params int[] orgIds);
        IEnumerable<Resource> LoadInOrgs(int pageindex, int pagesize, params int[] orgIds);
        
        void Delete(int id);

    }
}