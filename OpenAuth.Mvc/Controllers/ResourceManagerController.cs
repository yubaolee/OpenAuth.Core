using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using System;
using System.Linq;
using System.Web.Mvc;
using OpenAuth.App.SSO;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class ResourceManagerController : BaseController
    {
        public ResourceManagerApp App { get; set; }

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
                App.AddOrUpdate(model);
            }
            catch (Exception ex)
            {
                 Result.Status = false;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载某分类的所有Resources
        /// </summary>
        public string Load(Guid categoryId, int page = 1, int rows = 30)
        {
            return JsonHelper.Instance.Serialize(App.Load(AuthUtil.GetUserName(), categoryId, page, rows));
        }

        public string LoadForTree()
        {
            var models = App.LoadAll();
            return JsonHelper.Instance.Serialize(models);
        }

        [HttpPost]
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

        /// <summary>
        /// 为用户或角色分配权限
        /// </summary>
        /// <param name="firstId">关联表中的firstId.</param>
        /// <param name="key">关联表中的Key
        /// <para>如：UserResource/RoleResource</para>
        /// </param>
        /// <returns>ActionResult.</returns>
        public ActionResult AssignRes(Guid firstId, string key)
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
        public string LoadWithAccess(Guid cId, Guid firstId, string key)
        {
            return JsonHelper.Instance.Serialize(App.LoadWithAccess(AuthUtil.GetUserName(),key,firstId, cId));
        }
    }
}