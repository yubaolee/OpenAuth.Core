using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IRoleRepository :IRepository<Role>
    {
        IEnumerable<Role> LoadRoles(int pageindex, int pagesize);

        int GetRoleCntInOrgs(params string[] orgIds);
        IEnumerable<Role> LoadInOrgs(int pageindex, int pagesize, params string[] orgIds);
        IEnumerable<Role> LoadInOrgs(params string[] orgId);
        IEnumerable<Role> LoadForUser(string userId);

        void Delete(string id);

    }
}