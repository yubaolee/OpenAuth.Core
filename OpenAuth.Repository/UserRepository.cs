using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenAuth.Domain;

namespace OpenAuth.Repository
{
    public class UserRepository :BaseRepository<User>, IUserRepository
    {
        public User FindByAccount(string account)
        {
            return Context.Users.SingleOrDefault(u => u.Account == account);
        }

        public User FindById(string id)
        {
            return FindSingle(u => u.Account == id);
        }

        public IEnumerable<User> LoadUsers()
        {
            return Context.Users.ToList();
        }
    }
}
