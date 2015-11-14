using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IUserRepository :IRepository<User>
    {
        IEnumerable<User> LoadUsers();

        IEnumerable<User> LoadInOrgs(params int[] orgId);
        int GetUserCntInOrgs(params int[] orgIds);
        IEnumerable<User> LoadInOrgs(int pageindex, int pagesize, params int[] orgIds);

        void SetOrg(int userId, params int[] orgIds);

        /// <summary>
        /// 删除用户及与该用户相关的信息
        /// </summary>
        void Delete(int id);

    }
}