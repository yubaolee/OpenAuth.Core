using System.Collections.Generic;
using OpenAuth.Domain.Model;

namespace OpenAuth.Domain.Interface
{
    public interface IUserRepository
    {
        User FindByAccount(string account);
        User FindById(string id);

    }
}