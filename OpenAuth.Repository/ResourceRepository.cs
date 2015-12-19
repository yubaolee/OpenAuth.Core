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

        public int GetRoleCntInOrgs(params int[] orgIds)
        {
            return LoadInOrgs(orgIds).Count();
        }

        public IEnumerable<Role> LoadInOrgs(int pageindex, int pagesize, params int[] orgIds)
        {
            return LoadInOrgs(orgIds).OrderBy(u => u.Id).Skip((pageindex - 1) * pagesize).Take(pagesize);
        }

        public void Delete(int id)
        {
            Delete(u =>u.Id == id);
        }

        public IEnumerable<Role> LoadInOrgs(params int[] orgId)
        {
            var result = from role in Context.Roles.Where(u => orgId.Contains(u.OrgId)) select role;
                        
            return result;

        }
    }
}
