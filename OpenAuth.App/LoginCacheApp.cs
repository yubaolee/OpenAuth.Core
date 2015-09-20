using System.Web;
using OpenAuth.Domain;

namespace OpenAuth.App
{
    public  class LoginCacheApp
    {
        public static User GetLogin()
        {
            var session = HttpContext.Current.Session;
            return session["Login"] as User;
        }

        public static void SetLogin(User loginresp)
        {
            var session = HttpContext.Current.Session;
            var login = session["Login"] as User;
            if (login != null && login.UserId == loginresp.UserId)
            {
                return;
            }
            session["Login"] = loginresp;
        }
    }
}
