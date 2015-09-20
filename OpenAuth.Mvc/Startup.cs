using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(OpenAuth.Mvc.Startup))]
namespace OpenAuth.Mvc
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
