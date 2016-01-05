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

        //用于选择模块时使用
        public ActionResult LookUpMultiForUser(int userId)
        {
            ViewBag.UserId = userId;
            return View();
        }

        //为角色分配模块
        public ActionResult LookupMultiForRole(int roleId)
        {
            ViewBag.RoleId = roleId;
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
            var orgs = SessionHelper.GetSessionUser<LoginUserVM>().Modules;
            //添加根节点
            //orgs.Add(new Module
            //{
            //    Id = 0,
            //    ParentId = -1,
            //    Name = "根节点",
            //    CascadeId = "0"
            //});
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string LoadModuleWithRoot()
        {
            var orgs = SessionHelper.GetSessionUser<LoginUserVM>().Modules.MapToList<ModuleView>();
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

        public string LoadForUser(int userId)
        {
            var orgs = _app.LoadForUser(userId);
            //添加根节点
            orgs.Add(new Module
            {
                Id = 0,
                ParentId = -1,
                Name = "用户及角色拥有的模块",
                CascadeId = "0"
            });
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string LoadForRole(int roleId)
        {
            var orgs = _app.LoadForRole(roleId);
            //添加根节点
            orgs.Add(new Module
            {
                Id = 0,
                ParentId = -1,
                Name = "已为角色分配的模块",
                CascadeId = "0"
            });
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string AssignModuleForRole(int roleId, string moduleIds)
        {
            try
            {
                var ids = moduleIds.Split(',').Select(id => int.Parse(id)).ToArray();
                _app.AssignModuleForRole(roleId, ids);
            }
            catch (Exception e)
            {
                BjuiResponse.message = e.Message;
                BjuiResponse.statusCode = "300";
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        public string AssignModuleForUser(int userId, string moduleIds)
        {
            try
            {
                var ids = moduleIds.Split(',').Select(id => int.Parse(id)).ToArray();
                _app.AssignModuleForUser(userId, ids);
            }
            catch (Exception e)
            {
                BjuiResponse.message = e.Message;
                BjuiResponse.statusCode = "300";
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        #region 添加编辑模块
        public ActionResult Add(int id = 0)
        {
            return View(_app.Find(id));
        }

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