using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.SSO;
using OpenAuth.App.ViewModel;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class HomeController : BaseController
    {
         private ModuleManagerApp _app;

         public HomeController()
         {
             _app = AutofacExt.GetFromFac<ModuleManagerApp>();
        }
        
        public ActionResult Index()
        {
            ViewBag.NavBar = GetNavBar();
            return View();
        }

        public string GetNavBar()
        {
            var user = AuthUtil.GetCurrentUser();
            return BuilderNavBar(user.ModuleWithChildren);
        }


        public string BuilderNavBar(IEnumerable<TreeItem<ModuleView>> modules)
        {
            StringBuilder sb = new StringBuilder();
            foreach (var moduleView in modules)
            {
                if (moduleView.Children.Any())
                {
                    sb.Append("<li class=\"\">\r\n");
                    sb.Append("<a href=\"#\" class=\"dropdown-toggle\">\r\n");
                    sb.Append("<i class=\"menu-icon fa "+moduleView.Item.IconName+"\"></i>\r\n");
                    sb.Append("<span class=\"menu-text\">\r\n");
                    sb.Append(""+moduleView.Item.Name+"\r\n");
                    sb.Append("</span>\r\n");
                    sb.Append("\r\n");
                    sb.Append("<b class=\"arrow fa fa-angle-down\"></b>\r\n");
                    sb.Append("</a>\r\n");
                    sb.Append("\r\n");
                    sb.Append("<b class=\"arrow\"></b>\r\n");
                    sb.Append("<ul class=\"submenu\">");
                    sb.Append(BuilderNavBar(moduleView.Children));
                    sb.Append("</ul>");
                    sb.Append("</li>\r\n");
                }
                else
                {
                    sb.Append("<li class=\"\">\r\n");
                    sb.Append("<a href=\""+moduleView.Item.Url+"\">\r\n");
                    sb.Append("<i class=\"menu-icon fa "+moduleView.Item.IconName+"\"></i>\r\n");
                    sb.Append("<span class=\"menu-text\"> "+moduleView.Item.Name+ " </span>\r\n");
                    sb.Append("</a>\r\n");
                    sb.Append("\r\n");
                    sb.Append("<b class=\"arrow\"></b>\r\n");
                    sb.Append("</li>\r\n");
                }
            }
            return sb.ToString();
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
                + ">" + element.Name + "</button>");
            }
            ViewBag.Buttons = sb.ToString();
            return View();
        }

        [ChildActionOnly]
        public ActionResult Navbar()
        {
            ViewBag.NavBar = GetNavBar();
            return View();
        }
    }
}