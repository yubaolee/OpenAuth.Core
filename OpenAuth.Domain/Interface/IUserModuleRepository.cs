using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Domain.Interface
{
    public interface IUserModuleRepository : IRepository<UserModule>
    {
        void DeleteByUser(params int[] userIds);
        void AddUserModule(int userId, params int[] moduleIds);
    }
}
