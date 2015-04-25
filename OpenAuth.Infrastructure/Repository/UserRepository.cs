using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenAuth.Domain.Interface;
using OpenAuth.Domain.Model;

namespace OpenAuth.Infrastructure.Repository
{
    public class UserRepository :BaseRepository, IUserRepository
    {
        public User FindBy(string username)
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
    }

}
