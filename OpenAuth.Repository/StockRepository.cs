using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Repository
{
    public class StockRepository :BaseRepository<Stock>, IStockRepository
    {

        public IEnumerable<Stock> LoadStocks(int pageindex, int pagesize)
        {
            return Context.Stocks.OrderBy(u => u.Id).Skip((pageindex - 1) * pagesize).Take(pagesize);
        }

        public IEnumerable<Stock> LoadInOrgs(params Guid[] orgId)
        {
            var result = from stock in Context.Stocks where stock.OrgId != null && orgId.Contains(stock.OrgId.Value)
                select stock;
            return result;

        }

        public int GetStockCntInOrgs(params Guid[] orgIds)
        {
            return LoadInOrgs(orgIds).Count();
        }

        public IEnumerable<Stock> LoadInOrgs(int pageindex, int pagesize, params Guid[] orgIds)
        {
            return LoadInOrgs(orgIds).OrderBy(u =>u.Id).Skip((pageindex -1)*pagesize).Take(pagesize);
        }

        public void Delete(Guid id)
        {
            Delete(u =>u.Id == id);
        }
    }
}
