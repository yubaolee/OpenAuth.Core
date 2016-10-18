using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Mvc.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

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

            var moduleWithChildren = AuthUtil.GetCurrentUser().ModuleWithChildren;
            var modules = key == "UserModule" ? _app.LoadForUser(firstId) : _app.LoadForRole(firstId);

            CheckModule(moduleWithChildren, modules);

            ViewBag.Modules = BuilderModules(moduleWithChildren);

            return View();
        }

        private void CheckModule(IEnumerable<TreeItem<ModuleView>> moduleWithChildren, List<Module> modules)
        {
            foreach (var module in moduleWithChildren)
            {
                if (module.Children.Any())
                {
                    CheckModule(module.Children, modules);
                }
                else
                {
                    if (modules.Select(u => u.Id).Contains(module.Item.Id))
                    {
                        module.Item.Checked = true;
                    }
                }
            }
        }

        public string BuilderModules(IEnumerable<TreeItem<ModuleView>> modules)
        {
            StringBuilder sb = new StringBuilder();
            foreach (var moduleView in modules)
            {
                if (moduleView.Children.Any())
                {
                    sb.Append("<div class=\"layui-form-item\">\r\n");
                    sb.Append("<label class=\"layui-form-label\">" + moduleView.Item.Name + "</label>\r\n");
                    sb.Append("<div class=\"layui-input-block\">\r\n");
                    sb.Append(BuilderModules(moduleView.Children));
                    sb.Append("</div>\r\n");
                    sb.Append("</div>\r\n");
                }
                else
                {
                    sb.Append("<input type=\"checkbox\" name=\"like[dai]\" title=\"" + moduleView.Item.Name + "\"");
                    if (moduleView.Item.Checked)
                    {
                        sb.Append(" checked");
                    }
                    sb.Append(">\r\n");
                }
            }
            return sb.ToString();
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
            var orgs = AuthUtil.GetCurrentUser().ModuleWithChildren;
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string LoadModuleWithRoot()
        {
            var orgs = AuthUtil.GetCurrentUser().Modules.MapToList<ModuleView>();
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

        #endregion 添加编辑模块
    }
}