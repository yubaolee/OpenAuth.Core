using System.Linq;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App.Response;
using OpenAuth.App.SSO;

namespace OpenAuth.Mvc.Controllers
{
    /// <summary>
    /// 获取登录用户的全部信息
    /// </summary>
    public class UserSessionController : BaseController
    {
        UserWithAccessedCtrls user = AuthUtil.GetCurrentUser();
        /// <summary>
        /// 获取登录用户可访问的所有模块，及模块的操作菜单
        /// </summary>
        public string GetModulesTree()
        {
            var moduleTree = user.Modules.GenerateTree(u => u.Id, u => u.ParentId);
            return JsonHelper.Instance.Serialize(moduleTree);
        }

        public string GetModules(string pId)
        {
            var query = user.Modules;
            if (!string.IsNullOrEmpty(pId))
            {
                query = query.Where(u => u.ParentId == pId).ToList();
            }
            var data = new TableData
            {
                data = query,
                count = query.Count(),
            };
            return JsonHelper.Instance.Serialize(data);
        }

        /// <summary>
        /// 获取登录用户可访问的所有部门
        /// </summary>
        public string GetOrgs()
        {
            return JsonHelper.Instance.Serialize(user.Orgs);
        }

        //获取当前页面菜单
        public string GetButtonns()
        {
            var module = user.Modules.Single(u => u.Name.Contains(""));
            return JsonHelper.Instance.Serialize(module.Elements);
        }
    }
}