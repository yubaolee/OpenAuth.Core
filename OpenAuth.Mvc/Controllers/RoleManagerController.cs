using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using System;
using System.Linq;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class RoleManagerController : BaseController
    {
        private RoleManagerApp _app;

        public RoleManagerController()
        {
            _app = AutofacExt.GetFromFac<RoleManagerApp>();
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

        //添加或修改角色
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
        /// 加载角色下面的所有用户
        /// </summary>
        public string Load(int orgId, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(orgId, pageCurrent, pageSize));
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

        #region 为用户设置角色界面

        public ActionResult LookupMulti(int userId)
        {
            ViewBag.UserId = userId;
            return View();
        }

        public string LoadForOrgAndUser(int orgId, int userId)
        {
            return JsonHelper.Instance.Serialize(_app.LoadForOrgAndUser(orgId, userId));
        }

        public string AccessRoles(int userId, string ids)
        {
            var roleids = ids.Split(',').Select(id => int.Parse(id)).ToArray();
            _app.AccessRole(userId, roleids);
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        #endregion 为用户设置角色界面
    }
}