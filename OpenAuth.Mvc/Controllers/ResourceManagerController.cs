using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using System;
using System.Linq;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class ResourceManagerController : BaseController
    {
        private ResourceManagerApp _app;

        public ResourceManagerController()
        {
            _app = AutofacExt.GetFromFac<ResourceManagerApp>();
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

        //添加或修改Resource
        [HttpPost]
        public string Add(Resource model)
        {
            try
            {
                _app.AddOrUpdate(model);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        /// <summary>
        /// 加载某分类的所有Resources
        /// </summary>
        public string Load(int categoryId, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(categoryId, pageCurrent, pageSize));
        }

        public string LoadForTree()
        {
            var models = _app.LoadAll();
            //添加根节点
            models.Add(new Resource
            {
                Id = 0,
                ParentId = -1,
                Name = "根结点",
                CascadeId = "0"
            });
            return JsonHelper.Instance.Serialize(models);
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

        #region 为用户分配资源

        public ActionResult LookupMultiForUser(int userId)
        {
            ViewBag.UserId = userId;
            return View();
        }

        public string LoadWithUserAccess(int cId, int userId)
        {
            return JsonHelper.Instance.Serialize(_app.LoadWithAccess("UserResource",userId, cId));
        }

        public string AccessForUser(int userId, string ids)
        {
            try
            {
                var resIds = ids.Split(',').Select(id => int.Parse(id)).ToArray();
                _app.AssignResForUser(userId, resIds);
            }
            catch (Exception e)
            {
                BjuiResponse.message = e.Message;
                BjuiResponse.statusCode = "300";
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }
        #endregion 为用户分配资源

        #region 为角色分配资源
        public ActionResult LookupMultiForRole(int roleId)
        {
            ViewBag.RoleId = roleId;
            return View();
        }

        public string LoadWithRoleAccess(int cId, int roleId)
        {
            return JsonHelper.Instance.Serialize(_app.LoadWithAccess("RoleResource", roleId, cId));
        }

        public string AccessForRole(int roleId, string ids)
        {
            try
            {
                var resIds = ids.Split(',').Select(id => int.Parse(id)).ToArray();
                _app.AssignResForRole(roleId, resIds);
            }
            catch (Exception e)
            {
                BjuiResponse.message = e.Message;
                BjuiResponse.statusCode = "300";
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }
        #endregion
    }
}