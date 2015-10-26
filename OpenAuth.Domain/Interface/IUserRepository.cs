using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IUserRepository :IRepository<User>
    {
        User FindByAccount(string account);
        User FindById(string id);

        IEnumerable<User> LoadUsers();

    }
}