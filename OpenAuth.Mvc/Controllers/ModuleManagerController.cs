using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.Mvc.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Mvc.Controllers
{
    public class ModuleManagerController : BaseController
    {
        public ModuleManagerApp App { get; set; }

        // GET: /ModuleManager/
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Assign(string firstId, string key)
        {
            ViewBag.FirstId = firstId;
            ViewBag.ModuleType = key;

            var moduleWithChildren = AuthUtil.GetCurrentUser().Modules
                .GenerateTree(u =>u.Id, u =>u.ParentId);
            var modules = key == Define.USERMODULE ? App.LoadForUser(firstId) : App.LoadForRole(firstId);

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

                if (modules.Select(u => u.Id).Contains(module.Item.Id))
                {
                    module.Item.Checked = true;
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
                    sb.Append("<fieldset class=\"layui-elem-field\">\r\n");
                    sb.Append("<legend>");
                              BuildCheckbox(sb, moduleView);
                              sb.Append("</legend>\r\n");
                    sb.Append("<div class=\"layui-field-box\">\r\n");
                    sb.Append(BuilderModules(moduleView.Children));
                    sb.Append("</div>\r\n");
                    sb.Append("</fieldset>\r\n");

                    //sb.Append("<div class=\"layui-form-item\">\r\n");
                    //BuildCheckbox(sb, moduleView);
                    //sb.Append("<div class=\"layui-input-block\">\r\n");
                    //sb.Append(BuilderModules(moduleView.Children));
                    //sb.Append("</div>\r\n");
                    //sb.Append("</div>\r\n");
                }
                else
                {
                    BuildCheckbox(sb, moduleView);
                }
            }
            return sb.ToString();
        }

        private void BuildCheckbox(StringBuilder sb, TreeItem<ModuleView> moduleView)
        {
            sb.Append("<input type=\"checkbox\" value=\"" + moduleView.Item.Id + "\" title=\"" + moduleView.Item.Name + "\"");
            if (moduleView.Item.Checked)
            {
                sb.Append(" checked");
            }
            sb.Append(">\r\n");
        }

        /// <summary>
        /// 加载用户模块
        /// </summary>
        /// <param name="firstId">The user identifier.</param>
        /// <returns>System.String.</returns>
        public string LoadForUser(string firstId)
        {
            var orgs = App.LoadForUser(firstId);
            return JsonHelper.Instance.Serialize(orgs);
        }

        /// <summary>
        /// 加载角色模块
        /// </summary>
        /// <param name="firstId">The role identifier.</param>
        /// <returns>System.String.</returns>
        public string LoadForRole(string firstId)
        {
            var orgs = App.LoadForRole(firstId);
            return JsonHelper.Instance.Serialize(orgs);
        }

        #region 添加编辑模块

        //添加模块
        [HttpPost]
        [ValidateInput(false)]
        public string Add(Module model)
        {
            try
            {
                App.Add(model);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        //修改模块
        [HttpPost]
        [ValidateInput(false)]
        public string Update(Module model)
        {
            try
            {
                App.Update(model);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        [HttpPost]
        public string Delete(string[] ids)
        {
            try
            {
                App.Delete(ids);
            }
            catch (Exception e)
            {
                Result.Code = 500;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }

        #endregion 添加编辑模块

        /// <summary>
        /// 加载当前用户可访问模块的菜单
        /// </summary>
        /// <param name="moduleId">The module identifier.</param>
        /// <returns>System.String.</returns>
        public string LoadMenus(string moduleId)
        {
            var user = AuthUtil.GetCurrentUser();

            var module = user.Modules.Single(u => u.Id == moduleId);
             
            var data = new TableData
            {
                data = module.Elements,
                count = module.Elements.Count(),
            };
            return JsonHelper.Instance.Serialize(data);
        }

        //添加菜单
        [HttpPost]
        [ValidateInput(false)]
        public string AddMenu(ModuleElement model)
        {
            try
            {
                App.AddMenu(model);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 删除菜单
        /// </summary>
        [HttpPost]
        public string DelMenu(params string[] ids)
        {
            try
            {
                App.DelMenu(ids);
            }
            catch (Exception e)
            {
                Result.Code = 500;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }
    }
}