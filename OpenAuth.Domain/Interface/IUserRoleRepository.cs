using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Domain.Interface
{
    public interface IUserRoleRepository : IRepository<UserRole>
    {
        void DeleteByUser(params int[] userIds);
        void AddUserRole(int userId, params int[] roleIds);
    }
}
