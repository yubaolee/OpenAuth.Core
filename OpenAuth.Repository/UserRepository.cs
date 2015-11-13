using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Transactions;
using EntityFramework.Extensions;
using OpenAuth.Domain;

namespace OpenAuth.Repository
{
    public class UserRepository :BaseRepository<User>, IUserRepository
    {
        public IEnumerable<User> LoadUsers()
        {
            return Context.Users.ToList();
        }

        public IEnumerable<User> LoadInOrgs(params int[] orgId)
        {
            var result = from user in Context.Users
                     where (
                         Context.UserOrgs.Where(uo => orgId.Contains(uo.OrgId))
                         .Select(u => u.UserId)
                         .Distinct()
                     )
                     .Contains(user.Id)
                select user;
            return result;

        }

        public int GetUserCount(params int[] orgIds)
        {
            return LoadInOrgs(orgIds).Count();
        }

        public IEnumerable<User> LoadInOrgs(int pageindex, int pagesize, params int[] orgIds)
        {
            return LoadInOrgs(orgIds).OrderBy(u =>u.Name).Skip((pageindex -1)*pagesize).Take(pagesize);
        }

        public void AddWithOrg(User user, params int[] orgIds)
        {
            using (TransactionScope ts = new TransactionScope())
            {
               Add(user);
               Save();

                foreach (var orgId in orgIds)
                {
                    Context.UserOrgs.Add(new UserOrg{OrgId = orgId,UserId = user.Id});
                }
                Save();
                ts.Complete();
            }
        }

        public void Delete(int id)
        {
            using (TransactionScope ts = new TransactionScope())
            {
                Context.UserOrgs.Where(u => u.UserId == id).Delete();
                Delete(u =>u.Id == id);
                ts.Complete();
            }
        }
    }
}
