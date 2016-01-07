
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;

namespace OpenAuth.App
{
    public class StockManagerApp
    {
        private IStockRepository _repository;
        private IOrgRepository _orgRepository;

        public StockManagerApp(IStockRepository repository,
            IOrgRepository orgRepository)
        {
            _repository = repository;
            _orgRepository = orgRepository;
        }

        public int GetStockCntInOrg(int orgId)
        {
            if (orgId == 0)
            {
                return _repository.Find(null).Count();
            }
            else
            {
                return _repository.GetStockCntInOrgs(GetSubOrgIds(orgId));
            }
        }
        
        public List<Stock> LoadAll()
        {
            return _repository.Find(null).ToList();
        }

        /// <summary>
        /// 加载一个节点下面的一个或全部Stocks
        /// </summary>
        public dynamic Load(int orgId, int pageindex, int pagesize)
        {
            IEnumerable<Stock> Stocks;
            int total = 0;
            if (orgId == 0)
            {
                Stocks = _repository.LoadStocks(pageindex, pagesize);
                total = _repository.GetCount();
            }
            else
            {
                Stocks = _repository.LoadInOrgs(pageindex, pagesize,GetSubOrgIds(orgId));
                total = _repository.GetStockCntInOrgs(orgId);
            }

            return new 
            {
                total = total,
                list = Stocks,
                pageCurrent = pageindex
            };
        }

        /// <summary>
        /// 获取当前节点的所有下级节点
        /// </summary>
        private int[] GetSubOrgIds(int orgId)
        {
            var org = _orgRepository.FindSingle(u => u.Id == orgId);
            var orgs = _orgRepository.Find(u => u.CascadeId.Contains(org.CascadeId)).Select(u => u.Id).ToArray();
            return orgs;
        }

        public Stock Find(int id)
        {
            var stock = _repository.FindSingle(u => u.Id == id);
            if (stock == null) return new Stock();

            return stock;
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }

        public void AddOrUpdate(Stock model)
        {
            Stock stock  = new  Stock();
            model.CopyTo(stock);
            
            if (stock.Id == 0)
            {
                _repository.Add(stock);
            }
            else
            {
                _repository.Update(stock);
            }
           
        }

       
    }
}