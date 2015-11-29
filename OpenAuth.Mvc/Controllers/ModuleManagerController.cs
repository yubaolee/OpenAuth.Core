using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using System;
using System.Linq;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class ModuleManagerController : BaseController
    {
        private ModuleManagerApp _app;

        public ModuleManagerController()
        {
            _app = (ModuleManagerApp)DependencyResolver.Current.GetService(typeof(ModuleManagerApp));
        }

        //
        // GET: /ModuleManager/
        public ActionResult Index()
        {
            return View();
        }

        //用于选择模块时使用
        public ActionResult LookUpMulti(int userId)
        {
            ViewBag.UserId = userId;
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
            var orgs = _app.LoadForTree();
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
        /// 加载首页导航模块
        /// </summary>
        /// <returns>System.String.</returns>
        public string LoadForNav()
        {
            var orgs = _app.LoadForNav();
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
                Name = "已为用户分配的模块",
                CascadeId = "0"
            });
            return JsonHelper.Instance.Serialize(orgs);
        }

        public string AccessModule(int userId, string moduleIds)
        {
            try
            {
                var ids = moduleIds.Split(',').Select(id => int.Parse(id)).ToArray();
                _app.AccessModules(userId, ids);
            }
            catch (Exception e)
            {
                BjuiResponse.message = e.Message;
                BjuiResponse.statusCode = "300";
            }

            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        #region 命令操作
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