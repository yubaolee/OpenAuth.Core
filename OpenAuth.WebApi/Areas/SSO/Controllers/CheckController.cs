using System.Web.Http;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.WebApi.Areas.SSO.Models.Services;

namespace OpenAuth.WebApi.Areas.SSO.Controllers
{
    public class CheckController : Controller
    {
        private LoginApp _app;
        public CheckController()
        {
            _app = AutofacExt.GetFromFac<LoginApp>();
        }

        public bool GetStatus(string token = "", string requestid = "")
        {
            if (new UserAuthSessionService().GetCache(token))
            {
                return true;
            }

            return false;
        }

        public string GetUser(string token = "", string requestid = "")
        {
            var user = new UserAuthSessionService().Get(token);
            if (user != null)
            {
                return JsonHelper.Instance.Serialize(_app.GetLoginUser(user.UserName));
            }

            return string.Empty;
        }
    }
}