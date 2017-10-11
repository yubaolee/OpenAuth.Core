using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IResourceRepository :IRepository<Resource>
    {
        IEnumerable<Resource> LoadResources(int pageindex, int pagesize);

        IEnumerable<Resource> LoadInOrgs(params string[] orgId);
        int GetResourceCntInOrgs(params string[] orgIds);
        IEnumerable<Resource> LoadInOrgs(int pageindex, int pagesize, params string[] orgIds);
        
        void Delete(string id);

    }
}