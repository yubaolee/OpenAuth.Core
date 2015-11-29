using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Repository
{
    public class UserRoleRepository :BaseRepository<UserRole>, IUserRoleRepository
    {
        public void DeleteByUser(params int[] userIds)
        {
             Delete(u =>userIds.Contains(u.UserId));
        }

        public void AddUserRole(int userId, params int[] roleIds)
        {

            foreach (var roleid in roleIds)
            {
                Add(new UserRole
                {
                    UserId = userId,
                    RoleId = roleid,
                    OperateTime = DateTime.Now
                });
            }
            Save();
            
        }
    }
}
