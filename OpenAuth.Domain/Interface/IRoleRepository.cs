using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IRoleRepository :IRepository<Role>
    {
        IEnumerable<Role> LoadRoles(int pageindex, int pagesize);

        int GetRoleCntInOrgs(params Guid[] orgIds);
        IEnumerable<Role> LoadInOrgs(int pageindex, int pagesize, params Guid[] orgIds);
        IEnumerable<Role> LoadInOrgs(params Guid[] orgId);
        IEnumerable<Role> LoadForUser(Guid userId);

        void Delete(Guid id);

    }
}