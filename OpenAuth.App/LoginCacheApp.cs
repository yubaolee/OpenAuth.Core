using System.Web;

using OpenAuth.App.DTO;

namespace OpenAuth.App
{
    public  class LoginCacheApp
    {
        public static LoginResponse GetLogin()
        {
            var session = HttpContext.Current.Session;
            return session["Login"] as LoginResponse;
        }

        public static void SetLogin(LoginResponse loginresp)
        {
            var session = HttpContext.Current.Session;
            var login = session["Login"] as LoginResponse;
            if (login != null && login.UserId == loginresp.UserId)
            {
                return;
            }
            session["Login"] = loginresp;
        }
    }
}
