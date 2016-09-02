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
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        /// <summary>
        /// 加载组织下面的所有用户
        /// </summary>
        public string Load(Guid orgId, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(orgId, pageCurrent, pageSize));
        }

        public string Delete(Guid Id)
        {
            try
            {
                _app.Delete(Id);
                //foreach (var obj in Id.Split(','))
                //{
                //    _app.Delete(int.Parse(obj));
                //}
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