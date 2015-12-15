using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface ICategoryRepository :IRepository<Category>
    {
        IEnumerable<Category> LoadCategorys(int pageindex, int pagesize);

        IEnumerable<Category> LoadInOrgs(params int[] orgId);
        int GetCategoryCntInOrgs(params int[] orgIds);
        IEnumerable<Category> LoadInOrgs(int pageindex, int pagesize, params int[] orgIds);
        
        void Delete(int id);

    }
}