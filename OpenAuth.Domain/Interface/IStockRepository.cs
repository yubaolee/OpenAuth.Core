using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface IStockRepository :IRepository<Stock>
    {
        IEnumerable<Stock> LoadStocks(int pageindex, int pagesize);

        IEnumerable<Stock> LoadInOrgs(params string[] orgId);
        int GetStockCntInOrgs(params string[] orgIds);
        IEnumerable<Stock> LoadInOrgs(int pageindex, int pagesize, params string[] orgIds);
        
        void Delete(string id);

    }
}