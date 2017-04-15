using System;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Repository
{
    public class ResourceRepository : BaseRepository<Resource>, IResourceRepository
    {
        public IEnumerable<Resource> LoadInOrgs(int pageindex, int pagesize, params Guid[] orgIds)
        {
            return LoadInOrgs(orgIds).OrderBy(u => u.Id).Skip((pageindex - 1) * pagesize).Take(pagesize);
        }

        public void Delete(Guid id)
        {
            Delete(u => u.Id == id);
        }

        public IEnumerable<Resource> LoadInOrgs(params Guid[] orgId)
        {
            bool isZero = orgId.Length == 1 && orgId[0] == Guid.Empty;  //判断传进来的是否为0
            var result = from resource in Context.Resources.Where(u =>isZero 
                         || u.CascadeId != null &&orgId.Contains(u.CategoryId.Value)) select resource;

            return result;
        }

        public IEnumerable<Resource> LoadResources(int pageindex, int pagesize)
        {
            return Context.Resources.OrderBy(u => u.Id).Skip((pageindex - 1) * pagesize).Take(pagesize);
        }

        public int GetResourceCntInOrgs(params Guid[] orgIds)
        {
            return LoadInOrgs(orgIds).Count();
        }
    }
}