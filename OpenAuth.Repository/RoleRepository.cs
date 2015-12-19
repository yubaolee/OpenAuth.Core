using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Repository
{
    public class ResourceRepository : BaseRepository<Resource>, IResourceRepository
    {
        public IEnumerable<Resource> LoadInOrgs(int pageindex, int pagesize, params int[] orgIds)
        {
            return LoadInOrgs(orgIds).OrderBy(u => u.Id).Skip((pageindex - 1) * pagesize).Take(pagesize);
        }

        public void Delete(int id)
        {
            Delete(u => u.Id == id);
        }

        public IEnumerable<Resource> LoadInOrgs(params int[] orgId)
        {
            var result = from resource in Context.Resources.Where(u => orgId.Contains(u.CategoryId)) select resource;

            return result;
        }

        public IEnumerable<Resource> LoadResources(int pageindex, int pagesize)
        {
            return Context.Resources.OrderBy(u => u.Id).Skip((pageindex - 1) * pagesize).Take(pagesize);
        }

        public int GetResourceCntInOrgs(params int[] orgIds)
        {
            return LoadInOrgs(orgIds).Count();
        }
    }
}