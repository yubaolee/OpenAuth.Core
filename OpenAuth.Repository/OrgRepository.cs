using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Repository
{
    public class OrgRepository : BaseRepository<Org>, IOrgRepository
    {
        public IEnumerable<Org> LoadOrgs()
        {
            return Find();
        }
    }
}
