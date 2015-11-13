using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IUserRepository :IRepository<User>
    {
        IEnumerable<User> LoadUsers();

        IEnumerable<User> LoadInOrgs(params int[] orgId);
        int GetUserCount(params int[] orgIds);
        IEnumerable<User> LoadInOrgs(int pageindex, int pagesize, params int[] orgIds);

        /// <summary>
        /// 添加用户
        /// </summary>
        void AddWithOrg(User user, params int[] orgIds);

        /// <summary>
        /// 删除用户及与该用户相关的信息
        /// </summary>
        void Delete(int id);

    }
}