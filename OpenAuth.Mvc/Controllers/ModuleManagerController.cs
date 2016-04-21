using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using System;
using System.Linq;
using System.Web.Mvc;
using Infrastructure.Helper;
using OpenAuth.App.ViewModel;

namespace OpenAuth.Mvc.Controllers
{
    public class ModuleManagerController : BaseController
    {
        private ModuleManagerApp _app;

        public ModuleManagerController()
        {
            _app = AutofacExt.GetFromFac<ModuleManagerApp>();
        }

        //
        // GET: /ModuleManager/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Assign(int firstId, string key)
        {
            ViewBag.FirstId = firstId;
            ViewBag.ModuleType = key;
            return View();
        }

        /// <summary>
        /// 加载模块下面的所有模块
        /// </summary>
        public string Load(int orgId, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(orgId, pageCurrent, pageSize));
        }

        /// <summary>
        /// 直接加载所有的模块
        /// </summary>
        public string LoadForTree()
        {
            var orgs = AutofacExt.GetFromFac<LoginApp>().GetLoginUser().Modules;
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string LoadModuleWithRoot()
        {
            var orgs = AutofacExt.GetFromFac<LoginApp>().GetLoginUser().Modules.MapToList<ModuleView>();
            //添加根节点
            orgs.Add(new Module
            {
                Id = 0,
                ParentId = -1,
                Name = "根节点",
                CascadeId = "0"
            });
            return JsonHelper.Instance.Serialize(orgs);
        }

        /// <summary>
        /// 加载用户模块
        /// </summary>
        /// <param name="firstId">The user identifier.</param>
        /// <returns>System.String.</returns>
        public string LoadForUser(int firstId)
        {
            var orgs = _app.LoadForUser(firstId);
            return JsonHelper.Instance.Serialize(orgs);
        }

        /// <summary>
        /// 加载角色模块
        /// </summary>
        /// <param name="firstId">The role identifier.</param>
        /// <returns>System.String.</returns>
        public string LoadForRole(int firstId)
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
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
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
        #endregion

    }
}