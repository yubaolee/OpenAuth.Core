using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IStockRepository :IRepository<Stock>
    {
        IEnumerable<Stock> LoadStocks(int pageindex, int pagesize);

        IEnumerable<Stock> LoadInOrgs(params int[] orgId);
        int GetStockCntInOrgs(params int[] orgIds);
        IEnumerable<Stock> LoadInOrgs(int pageindex, int pagesize, params int[] orgIds);
        
        void Delete(int id);

    }
}