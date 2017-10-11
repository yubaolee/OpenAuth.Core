using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Repository
{
    public class OrgRepository : BaseRepository<Org>, IOrgRepository
    {
        public IEnumerable<Org> LoadOrgs()
        {
            return Find();
        }

        /// <summary>
        /// 加载用户的所有机构
        /// </summary>
        public IEnumerable<Org> LoadByUser(string userId)
        {
            var result = from userorg in Context.Relevances
                join org in Context.Orgs on userorg.SecondId equals org.Id
                where userorg.FirstId == userId && userorg.Key =="UserOrg"
                select org;
            return result;

        }

        /// <summary>
        /// 加载角色的所有机构
        /// </summary>
        public IEnumerable<Org> LoadByRole(string roleId)
        {
            var result = from userorg in Context.Relevances
                         join org in Context.Orgs on userorg.SecondId equals org.Id
                         where userorg.FirstId == roleId && userorg.Key == "RoleOrg"
                         select org;
            return result;

        }

        public IEnumerable<Org> GetSubOrgs(string orgId)
        {
            string cascadeId = "0.";
            if (orgId != string.Empty)
            {
                var org = FindSingle(u => u.Id == orgId);
                if (org == null)
                    throw new Exception("未能找到指定对象信息");
                cascadeId = org.CascadeId;
            }

            return Find(u => u.CascadeId.Contains(cascadeId));
        }
    }
}
