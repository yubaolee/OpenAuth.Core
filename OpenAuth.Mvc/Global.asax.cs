using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using Infrastructure;

namespace OpenAuth.Mvc
{
    public class MvcApplication : HttpApplication
    {
        protected void Application_Start()
        {
            AutofacExt.InitAutofac();


            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            LogHelper.Log("启动Web");
        }
    }
}
