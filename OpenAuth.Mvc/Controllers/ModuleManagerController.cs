
using System;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;

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

        /// <summary>
        /// 加载模块下面的所有模块
        /// </summary>
        public string Load(int orgId, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(orgId, pageCurrent, pageSize));
        }

        /// <summary>
        /// 加载tree结构
        /// </summary>
        public string LoadForTree(bool bAll=false)
        {
            var orgs = _app.LoadForTree(bAll);
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
    }
}