using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Infrastructure;
using LeaRun.Util.WebControl;
using OpenAuth.App;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class UserManagerController : BaseController
    {
        private UserManagerApp _app;

        public UserManagerController()
        {
            _app = AutofacExt.GetFromFac<UserManagerApp>();
        }

        //
        // GET: /UserManager/
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }

        //添加或修改组织
        [HttpPost]
        public string Add(UserView view)
        {
            try
            {
                _app.AddOrUpdate(view);
                
            }
            catch (Exception ex)
            {
                 Result.Status = false;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载组织下面的所有用户
        /// </summary>
        public string Load(Guid orgId, int page = 1, int rows = 30)
        {
            return JsonHelper.Instance.Serialize(_app.Load(orgId, page, rows));
        }

        [HttpPost]
        public string Delete(Guid[] ids)
        {
            try
            {
                _app.Delete(ids);
            }
            catch (Exception e)
            {
                 Result.Status = false;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }

        #region 获取权限数据

        /// <summary>
        /// 用户列表树 
        /// </summary>
        /// <returns>返回树形Json</returns>
        [HttpGet]
        public ActionResult GetUserCheckTreeJson()
        {
            var treeList = new List<TreeEntity>();
            string companyid = "";
            string departmentid = "";
            foreach (UserView item in _app.Load(Guid.Empty, 1, 10).rows)
            {
                TreeEntity tree = new TreeEntity();

                tree.id = item.Id.ToString();
                tree.text = item.Name;
                tree.value = item.Id.ToString();
                tree.isexpand = true;
                tree.complete = true;
                tree.hasChildren = false;
                tree.parentId = "0";
                tree.showcheck = true;
                tree.img = "fa fa-user";
                tree.Attribute = "mytype";
                tree.AttributeValue = "User";
                treeList.Add(tree);
            }
            return Content(treeList.TreeToJson());
        }

        /// <summary>
        /// 获取用户可访问的账号
        /// <para>李玉宝于2017-02-28 15:12:19</para>
        /// </summary>
        public string GetAccessedUsers()
        {
            IEnumerable<UserView> users =  _app.Load(Guid.Empty, 1, 10).rows;
            var result = new Dictionary<string , object>();
            foreach (var user in users)
            {
                var item = new
                {
                    Account = user.Account,
                    RealName = user.Name,

                };
                result.Add(user.Id.ToString(), item);
            }

            return JsonHelper.Instance.Serialize(result);
        }
        #endregion
    }
}