using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using System;
using System.Web.Mvc;
using OpenAuth.App.SSO;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    /// <summary>
    /// 进出库管理
    /// <para>本示例主要演示如何使用用户拥有的机构/资源</para>
    /// </summary>
    public class StockManagerController : BaseController
    {
        private StockManagerApp _app;

        public StockManagerController()
        {
            _app = AutofacExt.GetFromFac<StockManagerApp>();
        }

        //
        // GET: /UserManager/
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }

        //添加或修改Stock
        [HttpPost]
        public string Add(Stock model)
        {
            try
            {
               var newmodel =  new Stock();
                model.CopyTo(newmodel);
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
            return JsonHelper.Instance.Serialize(_app.Load(AuthUtil.GetUserName(), parentId, pageCurrent, pageSize));
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