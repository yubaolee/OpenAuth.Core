using System;
using System.Linq;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.ViewModel;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class UserManagerController : BaseController
    {
        private UserManagerApp _app;

        public UserManagerController()
        {
            _app = AutofacExt.GetFromFac<UserManagerApp>();
        }

        //
        // GET: /UserManager/
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }

        //添加或修改组织
        [HttpPost]
        public string Add(UserView view)
        {
            try
            {
                _app.AddOrUpdate(view);
                
            }
            catch (Exception ex)
            {
                 Result.Status = false;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载组织下面的所有用户
        /// </summary>
        public string Load(Guid orgId, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(orgId, pageCurrent, pageSize));
        }

        [HttpPost]
        public string Delete(Guid[] ids)
        {
            try
            {
                _app.Delete(ids);
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