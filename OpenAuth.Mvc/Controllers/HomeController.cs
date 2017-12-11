using System.Text;
using System.Web.Mvc;

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
                          + " data-type='" + element.DomId + "' "
                          + " class='layui-btn layui-btn-small " + element.Class + "' "
                          + element.Attr
                          + ">");
                if (!string.IsNullOrEmpty(element.Icon))
                {
                    sb.Append("<i class='layui-icon'>" + element.Icon + "</i>");
                }
                sb.Append(element.Name + "</button>");
            }
            ViewBag.Buttons = sb.ToString();
            return View();
        }
    }
}