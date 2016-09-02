using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IStockRepository :IRepository<Stock>
    {
        IEnumerable<Stock> LoadStocks(int pageindex, int pagesize);

        IEnumerable<Stock> LoadInOrgs(params Guid[] orgId);
        int GetStockCntInOrgs(params Guid[] orgIds);
        IEnumerable<Stock> LoadInOrgs(int pageindex, int pagesize, params Guid[] orgIds);
        
        void Delete(Guid id);

    }
}