using System.Web.Http;
using OpenAuth.WebApi.Areas.SSO.Models.Services;

namespace OpenAuth.WebApi.Areas.SSO.Controllers
{
    public class PassportController : ApiController
    {
        public bool Get(string token = "", string requestid = "")
        {
            if (new UserAuthSessionService().GetCache(token))
            {
                return true;
            }

            return false;
        }
    }
}