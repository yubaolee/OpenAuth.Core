using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IUserRepository :IRepository<User>
    {
        IEnumerable<User> LoadUsers(int pageindex, int pagesize);

        IEnumerable<User> LoadInOrgs(params string[] orgId);
        int GetUserCntInOrgs(params string[] orgIds);
        IEnumerable<User> LoadInOrgs(int pageindex, int pagesize, params string[] orgIds);

    }
}