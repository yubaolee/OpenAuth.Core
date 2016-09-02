using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IResourceRepository :IRepository<Resource>
    {
        IEnumerable<Resource> LoadResources(int pageindex, int pagesize);

        IEnumerable<Resource> LoadInOrgs(params Guid[] orgId);
        int GetResourceCntInOrgs(params Guid[] orgIds);
        IEnumerable<Resource> LoadInOrgs(int pageindex, int pagesize, params Guid[] orgIds);
        
        void Delete(Guid id);

    }
}