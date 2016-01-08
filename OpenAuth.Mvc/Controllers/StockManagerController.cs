using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using System;
using System.Web.Mvc;
using Infrastructure.Helper;
using OpenAuth.App.ViewModel;

namespace OpenAuth.Mvc.Controllers
{
    public class StockManagerController : BaseController
    {
        private StockManagerApp _app;

        public StockManagerController()
        {
            _app = AutofacExt.GetFromFac<StockManagerApp>();
        }

        //
        // GET: /UserManager/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Add(int id = 0)
        {
            return View(_app.Find(id));
        }

        //添加或修改Stock
        [HttpPost]
        public string Add(Stock model)
        {
            try
            {
               var newmodel =  new Stock();
                model.CopyTo(newmodel);
                newmodel.User = SessionHelper.GetSessionUser<LoginUserVM>().User.Account;
                _app.AddOrUpdate(newmodel);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        /// <summary>
        /// 加载节点下面的所有Stocks
        /// </summary>
        public string Load(int parentId, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(parentId, pageCurrent, pageSize));
        }
        
        public string Delete(int Id)
        {
            try
            {
                _app.Delete(Id);
            }
            catch (Exception e)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = e.Message;
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }
    }
}