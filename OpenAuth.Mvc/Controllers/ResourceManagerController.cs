using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using System;
using System.Linq;
using System.Web.Mvc;
using OpenAuth.Mvc.Models;

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
        [Authenticate]
        public ActionResult Index()
        {
            return View();
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

        /// <summary>
        /// 为用户或角色分配权限
        /// </summary>
        /// <param name="firstId">关联表中的firstId.</param>
        /// <param name="key">关联表中的Key
        /// <para>如：UserResource/RoleResource</para>
        /// </param>
        /// <returns>ActionResult.</returns>
        public ActionResult AssignRes(int firstId, string key)
        {
            ViewBag.FirstId = firstId;
            ViewBag.ModuleType = key;
            return View();
        }

        /// <summary>
        /// 加载带有授权的资源信息
        /// </summary>
        /// <param name="cId">分类ID</param>
        /// <param name="firstId">关联表中的firstId</param>
        /// <param name="key">关联表中的key</param>
        /// <returns>System.String.</returns>
        public string LoadWithAccess(int cId, int firstId, string key)
        {
            return JsonHelper.Instance.Serialize(_app.LoadWithAccess(key,firstId, cId));
        }
    }
}