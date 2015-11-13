using Infrastructure;
using OpenAuth.App;
using OpenAuth.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using OpenAuth.App.ViewModel;

namespace OpenAuth.Mvc.Controllers
{
    public class UserManagerController : BaseController
    {
        private UserManagerApp _app;

        public UserManagerController()
        {
            _app = (UserManagerApp)DependencyResolver.Current.GetService(typeof(UserManagerApp));
        }

        //
        // GET: /UserManager/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Add()
        {
            return View();
        }

        //添加组织提交
        [HttpPost]
        public string Add(UserView org)
        {
            try
            {
                int[] orgIds = org.OrganizationIds.Split(',').Select(id => int.Parse(id)).ToArray();
                _app.Add(org, orgIds);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        public string Edit(string json)
        {
            try
            {
                var org = JsonHelper.Instance.Deserialize<User>(json);
            }
            catch (Exception ex)
            {
                BjuiResponse.statusCode = "300";
                BjuiResponse.message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(BjuiResponse);
        }

        /// <summary>
        /// 加载组织下面的所有用户
        /// </summary>
        public string Load(int orgId)
        {
            return JsonHelper.Instance.Serialize(_app.Load(orgId));
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