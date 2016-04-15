
using System;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;

namespace OpenAuth.Mvc.Controllers
{
 public class CategoryManagerController : BaseController
    {
        private CategoryManagerApp _app;

        public CategoryManagerController()
        {
            _app = AutofacExt.GetFromFac<CategoryManagerApp>();
        }

        //
        // GET: /UserManager/
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 加载分类下面的所有分类
        /// </summary>
        public string Load(int parentId, int pageCurrent = 1, int pageSize = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(parentId, pageCurrent, pageSize));
        }

     public string LoadForTree()
     {
         var models = _app.LoadAll();
         //添加根节点
         models.Add(new Category
         {
             Id = 0,
             ParentId = -1,
             Name = "根结点",
             CascadeId = "0"
         });
         return JsonHelper.Instance.Serialize(models);
     }

        public ActionResult Add(int id = 0)
        {
            return View(_app.Find(id));
        }

        //添加或修改Category
        [HttpPost]
        public string Add(Category model)
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

        
    }
}