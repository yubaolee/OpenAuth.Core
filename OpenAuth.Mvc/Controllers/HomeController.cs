using System.Text;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App.SSO;

namespace OpenAuth.Mvc.Controllers
{
    public class HomeController : BaseController
    {

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Main()
        {
            return View();
        }
       
        public string GetNavBar()
        {
            var user = AuthUtil.GetCurrentUser();
            return JsonHelper.Instance.Serialize(user.ModuleWithChildren);
        }
        
        public ActionResult Git()
        {
            return View();
        }

        /// <summary>
        /// 所有页面按钮控制分部视图
        /// </summary>
        /// <returns>ActionResult.</returns>
        [ChildActionOnly]
        public ActionResult MenuHeader()
        {
            var sb = new StringBuilder();
            foreach (var element in CurrentModule.Elements)
            {
                sb.Append("<button "
                          + " id='" + element.DomId + "' "
                          + " class='btn btn-sm " + element.Class + "' "
                          + " onclick='" + element.Script + "' " + element.Attr
                          + ">");
                if (!string.IsNullOrEmpty(element.Icon))
                {
                    sb.Append("<i class='ace-icon fa fa-" + element.Icon + "'></i>");
                }
                sb.Append(element.Name + "</button>");
            }
            ViewBag.Buttons = sb.ToString();
            return View();
        }
    }
}