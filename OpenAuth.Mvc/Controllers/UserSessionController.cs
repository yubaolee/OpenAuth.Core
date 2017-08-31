using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App.SSO;

namespace OpenAuth.Mvc.Controllers
{
    /// <summary>
    /// 获取登陆用户的全部信息
    /// </summary>
    public class UserSessionController : BaseController
    {
        /// <summary>
        /// 获取登陆用户可访问的所有模块，及模块的操作菜单
        /// </summary>
        public string GetModulesTree()
        {
            var user = AuthUtil.GetCurrentUser();
            return JsonHelper.Instance.Serialize(user.Modules.GenerateTree(u => u.Id, u => u.ParentId));
        }

        /// <summary>
        /// 获取登陆用户可访问的所有部门
        /// </summary>
        public string GetOrgsTree()
        {
            var user = AuthUtil.GetCurrentUser();
            return JsonHelper.Instance.Serialize(user.Orgs.GenerateTree(u => u.Id, u => u.ParentId));
        }
    }
}