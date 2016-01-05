using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IRoleRepository :IRepository<Role>
    {
        IEnumerable<Role> LoadRoles(int pageindex, int pagesize);

        int GetRoleCntInOrgs(params int[] orgIds);
        IEnumerable<Role> LoadInOrgs(int pageindex, int pagesize, params int[] orgIds);

        void Delete(int id);

    }
}