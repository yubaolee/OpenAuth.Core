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
        public dynamic Load(string username, int orgId, int pageindex, int pagesize)
        {
            return _service.Load(username, orgId, pageindex, pagesize);
        }

        public void Delete(int id)
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