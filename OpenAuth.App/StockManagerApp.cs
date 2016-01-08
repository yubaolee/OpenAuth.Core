
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using Infrastructure.Helper;
using OpenAuth.App.ViewModel;

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

        /// <summary>
        /// 根据部门ID得到进出库信息
        /// </summary>
        public dynamic Load(int orgId, int pageindex, int pagesize)
        {
            IEnumerable<Stock> Stocks;
            var user = SessionHelper.GetSessionUser<LoginUserVM>();
            var loginOrgs = user.AccessedOrgs.Select(u => u.Id).ToArray();

            int total;
            if (orgId == 0)
            {
               
                if (loginOrgs.Length == 0)  //改用户没有任何可见机构
                {
                    Stocks = _repository.Find(pageindex, pagesize, "", u => u.User == user.User.Account);
                    total = _repository.GetCount(u =>u.User ==user.User.Account);
                }
                else
                {
                    Stocks = _repository.LoadInOrgs(pageindex, pagesize, loginOrgs);
                    total = _repository.GetStockCntInOrgs(loginOrgs);
                }
              
            }
            else  //加载选择的机构及用户可访问的所有子机构
            {
                var orgs = _orgRepository.GetSubOrgs(orgId).Where(u =>loginOrgs.Contains(u.Id));
                List<int> orgIds = orgs.Select(u => u.Id).ToList();
                orgIds.Add(orgId);
                Stocks = _repository.LoadInOrgs(pageindex, pagesize, orgIds.ToArray());
                total = _repository.GetStockCntInOrgs(orgIds.ToArray());
            }

            return new 
            {
                total = total,
                list = Stocks,
                pageCurrent = pageindex
            };
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