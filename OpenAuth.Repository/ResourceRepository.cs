using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Repository
{
    public class RoleRepository :BaseRepository<Role>, IRoleRepository
    {
        public IEnumerable<Role> LoadRoles(int pageindex, int pagesize)
        {
            return Context.Roles.OrderBy(u => u.Id).Skip((pageindex - 1) * pagesize).Take(pagesize);
        }

        public int GetRoleCntInOrgs(params Guid[] orgIds)
        {
            return LoadInOrgs(orgIds).Count();
        }

        public IEnumerable<Role> LoadInOrgs(int pageindex, int pagesize, params Guid[] orgIds)
        {
            return LoadInOrgs(orgIds).OrderBy(u => u.Id).Skip((pageindex - 1) * pagesize).Take(pagesize);
        }

        public void Delete(Guid id)
        {
            Delete(u =>u.Id == id);
        }

        public IEnumerable<Role> LoadInOrgs(params Guid[] orgId)
        {
            var roles = Context.Relevances.Where(u => u.Key == "RoleOrg"
           && orgId.Contains(u.SecondId)).Select(u => u.FirstId);   //机构关联的角色

            var result = from role in Context.Roles.Where(u =>roles.Contains(u.Id)) select role;
                        
            return result;

        }

        public IEnumerable<Role> LoadForUser(Guid userId)
        {

            if (userId == Guid.Empty)
                return Find(null);

            var userRoleIds =
               Context.Relevances.Where(u => u.FirstId == userId && u.Key == "UserRole")
               .Select(u => u.SecondId).ToList();

            return Find(u => userRoleIds.Contains(u.Id));
        }
    }
}
