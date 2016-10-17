using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using System;
using System.Web.Mvc;
using OpenAuth.App.SSO;
using OpenAuth.App.ViewModel;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class ModuleManagerController : BaseController
    {
        private ModuleManagerApp _app;

        public ModuleManagerController()
        {
            _app = AutofacExt.GetFromFac<ModuleManagerApp>();
        }

        // GET: /ModuleManager/
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Assign(Guid firstId, string key)
        {
            ViewBag.FirstId = firstId;
            ViewBag.ModuleType = key;
            return View();
        }

        /// <summary>
        /// 加载模块下面的所有模块
        /// </summary>
        public string Load(Guid orgId, int page = 1, int rows = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(orgId, page, rows));
        }

        /// <summary>
        /// 直接加载所有的模块
        /// </summary>
        public string LoadForTree()
        {
            var orgs = AuthUtil.GetCurrentUser().Modules;
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string LoadModuleWithRoot()
        {
            var orgs = AuthUtil.GetCurrentUser().Modules.MapToList<ModuleView>();
            return JsonHelper.Instance.Serialize(orgs);
        }

        /// <summary>
        /// 加载用户模块
        /// </summary>
        /// <param name="firstId">The user identifier.</param>
        /// <returns>System.String.</returns>
        public string LoadForUser(Guid firstId)
        {
            var orgs = _app.LoadForUser(firstId);
            return JsonHelper.Instance.Serialize(orgs);
        }

        /// <summary>
        /// 加载角色模块
        /// </summary>
        /// <param name="firstId">The role identifier.</param>
        /// <returns>System.String.</returns>
        public string LoadForRole(Guid firstId)
        {
            var orgs = _app.LoadForRole(firstId);
            return JsonHelper.Instance.Serialize(orgs);
        }


        #region 添加编辑模块
        //添加或修改模块
        [HttpPost]
        public string Add(Module model)
        {
            try
            {
                _app.AddOrUpdate(model);
            }
            catch (Exception ex)
            {
                 Result.Status = false;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        [HttpPost]
        public string Delete(Guid[] ids)
        {
            try
            {
                foreach (var obj in ids)
                {
                    _app.Delete(obj);
                }
            }
            catch (Exception e)
            {
                 Result.Status = false;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }
        #endregion

    }
}