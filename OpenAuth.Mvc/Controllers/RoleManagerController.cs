using System;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;

namespace OpenAuth.Mvc.Controllers
{
    public class RoleManagerController : BaseController
    {
        private RoleManagerApp _app;

        public RoleManagerController()
        {
            _app = (RoleManagerApp)DependencyResolver.Current.GetService(typeof(RoleManagerApp));
        }

        //
        // GET: /RoleManager/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Add(int id = 0)
        {
            return View(_app.Find(id));
        }

        //添加或修改组织
        [HttpPost]
        public string Add(Role role)
        {
            try
            {
                _app.AddOrUpdate(role);
                
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
        public string Load(int orgId, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(orgId, pageCurrent, pageSize));
        }

        //获取组织下面用户个数
        public int GetCount(int orgId)
        {
            return _app.GetRoleCntInOrg(orgId);
        }

        public string Delete(string Id)
        {
            try
            {
                foreach (var obj in Id.Split(','))
                {
                    _app.Delete(int.Parse(obj));
                }
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