using System;
using OpenAuth.Domain;
using Infrastructure;
using OpenAuth.Domain.Service;

namespace OpenAuth.App
{
    public class StockManagerApp
    {
        private StockManagerService _service;

        public StockManagerApp(StockManagerService service)
        {
            _service = service;
        }

        /// <summary>
        /// 根据部门ID得到进出库信息
        /// </summary>
        public dynamic Load(string username, Guid orgId, int page, int rows)
        {
            return _service.Load(username, orgId, page, rows);
        }

        public void Delete(Guid[] id)
        {
            _service.Delete(id);
        }

        public void AddOrUpdate(Stock model)
        {
            Stock stock  = new  Stock();
            model.CopyTo(stock);
            _service.AddOrUpdate(stock);
           
        }

       
    }
}