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
        public StockManagerApp App { get; set; }

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
                App.AddOrUpdate(newmodel);
            }
            catch (Exception ex)
            {
                 Result.Status = false;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载节点下面的所有Stocks
        /// </summary>
        public string Load(Guid parentId, int page = 1, int rows = 30)
        {
            return JsonHelper.Instance.Serialize(App.Load(AuthUtil.GetUserName(), parentId, page, rows));
        }
        
        public string Delete(Guid[] ids)
        {
            try
            {
                App.Delete(ids);
            }
            catch (Exception e)
            {
                 Result.Status = false;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }
    }
}