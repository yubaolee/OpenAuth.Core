using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IUserRepository :IRepository<User>
    {
        IEnumerable<User> LoadUsers(int pageindex, int pagesize);

        IEnumerable<User> LoadInOrgs(params Guid[] orgId);
        int GetUserCntInOrgs(params Guid[] orgIds);
        IEnumerable<User> LoadInOrgs(int pageindex, int pagesize, params Guid[] orgIds);

    }
}