using System.Web;

namespace Infrastructure.Auth
{
    public class CacheKey
    {
        public static string SessionName = "OpenAuth";
        public static string UserSessionName = "Session_";
        private static string GetSessionId()
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies.Get(SessionName);
            string remoteBrowserIp = WebUtility.GetIP();
            return UserSessionName + remoteBrowserIp + ":" + cookie.Value;
        }
        public static string UserID
        {
            get { return GetSessionId(); }
        }
    }
}
