using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Domain.Interface
{
    public  interface IOrgRepository :IRepository<Org>
    {
        IEnumerable<Org> LoadOrgs();

        IEnumerable<Org> LoadByUser(int userId);
    }
}
