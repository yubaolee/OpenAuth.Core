using System;
using System.Linq;
using System.Linq.Expressions;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Domain.Service
{
    /// <summary>
    /// 领域服务
    /// <para>进出库管理服务</para>
    /// </summary>
    public class StockManagerService
    {
        private IStockRepository _repository;
        private IOrgRepository _orgRepository;
        private AuthoriseFactory _factory;

        public StockManagerService(IStockRepository repository,
            IOrgRepository orgRepository, AuthoriseFactory service)
        {
            _repository = repository;
            _orgRepository = orgRepository;
            _factory = service;
        }

        /// <summary>
        /// 根据部门ID得到进出库信息
        /// </summary>
        public dynamic Load(string username, Guid orgId, int pageindex, int pagesize)
        {

            var  service = _factory.Create(username);
            if (service.Orgs.Count == 0) //用户没有任何可见机构
            {
                return new
                {
                    total = 0,
                    records = 0,
                    page = pageindex
                };
            }

            var orgIds = service.Orgs.Select(u => u.Id).ToArray();  //用户可访问的机构ID

            var orgs = _orgRepository.GetSubOrgs(orgId)   //点击的节点与用户可访问的机构合并
                .Where(u => orgIds.Contains(u.Id))
                .Select(u => u.Id).ToArray();

            var keys = service.Resources.Select(r => r.Key);    //用户可访问的资源的KEY列表

            Expression<Func<Stock, bool>> exp = u => u.OrgId != null &&orgs.Contains(u.OrgId.Value) && (u.Viewable == "" || keys.Contains(u.Viewable));
            var stocks = _repository.Find(pageindex, pagesize, "", exp);
            int total = _repository.GetCount(exp);


            return new
            {
                records = total,
                total = (int)Math.Ceiling((double)total / pagesize),
                rows = stocks,
                page = pageindex
            };
        }

        public Stock Find(Guid id)
        {
            var stock = _repository.FindSingle(u => u.Id == id);
            if (stock == null) return new Stock();

            return stock;
        }

        public void Delete(Guid[] id)
        {
            _repository.Delete(u =>id.Contains(u.Id));
        }

        public void AddOrUpdate(Stock stock)
        {

            if (stock.Id == Guid.Empty)
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
