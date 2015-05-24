using System;
using System.Linq;
using OpenAuth.Domain.Interface;
using OpenAuth.Domain.Model;

namespace OpenAuth.Repository
{
    public class UserRepository :BaseRepository, IUserRepository
    {
        public User FindByAccount(string username)
        {
            try
            {
                return _Context.Users.First(e => e.Account == username);
            }
            catch (Exception)
            {
                return null;
            }
        }

        public User FindById(string id)
        {
            try
            {
                return _Context.Users.First(e => e.Id == id);
            }
            catch (Exception)
            {
                return null;
            }
        }
    }

}
