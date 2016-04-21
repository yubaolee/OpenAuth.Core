using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Domain.Interface
{
    public  interface IOrgRepository :IRepository<Org>
    {
        IEnumerable<Org> LoadOrgs();

        IEnumerable<Org> LoadByUser(int userId);

        /// <summary>
        /// 得到全部子部门
        /// </summary>
        /// <param name="orgId">部门ID</param>
        IEnumerable<Org> GetSubOrgs(int orgId);

        /// <summary>
        /// 获取包括自己在内的全部子部门
        /// </summary>
        /// <param name="orgId">The org identifier.</param>
        /// <returns>IEnumerable&lt;Org&gt;.</returns>
        IEnumerable<Org> GetSubWithOwn(int orgId);
    }
}
