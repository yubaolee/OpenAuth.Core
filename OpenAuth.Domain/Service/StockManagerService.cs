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
        private AuthoriseService _authoriseService;

        public StockManagerService(IStockRepository repository,
            IOrgRepository orgRepository, AuthoriseService service)
        {
            _repository = repository;
            _orgRepository = orgRepository;
            _authoriseService = service;
        }

        /// <summary>
        /// 根据部门ID得到进出库信息
        /// </summary>
        public dynamic Load(string username, int orgId, int pageindex, int pagesize)
        {

            _authoriseService.GetUserAccessed(username);
            if (_authoriseService.Orgs.Count == 0) //用户没有任何可见机构
            {
                return new
                {
                    total = 0,
                    pageCurrent = pageindex
                };
            }

            var orgIds = _authoriseService.Orgs.Select(u => u.Id).ToArray();  //用户可访问的机构ID

            var orgs = _orgRepository.GetSubWithOwn(orgId)   //点击的节点与用户可访问的机构合并
                .Where(u => orgIds.Contains(u.Id))
                .Select(u => u.Id).ToArray();

            var keys = _authoriseService.Resources.Select(r => r.Key);    //用户可访问的资源的KEY列表

            //由于库存Stock表开始没有设计资源有关的字段，暂时用User字段代替
            Expression<Func<Stock, bool>> exp = u => orgs.Contains(u.OrgId) && (u.User == "" || keys.Contains(u.User));
            var stocks = _repository.Find(pageindex, pagesize, "", exp);
            int total = _repository.GetCount(exp);


            return new
            {
                total = total,
                list = stocks,
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

        public void AddOrUpdate(Stock stock)
        {

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
