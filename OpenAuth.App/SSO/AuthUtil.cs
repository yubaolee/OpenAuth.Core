using System;
using System.Configuration;
using System.Web;
using Infrastructure;

namespace OpenAuth.App.SSO
{
    public class AuthUtil
    {
        static HttpHelper _helper = new HttpHelper(ConfigurationManager.AppSettings["SSOPassport"]);
        public static bool CheckLogin(string token, string remark = "")
        {
           
            var requestUri = string.Format("/api/Passport?token={0}&requestid={1}", token, remark);

            try
            {
                var value = _helper.Get(null, requestUri);
                return bool.Parse(value);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static string Login(string appKey, string username, string pwd)
        {
            var requestUri = "/SSO/Login/Check";

            try
            {
                var value = _helper.Post(new
                {
                    AppKey = appKey,
                    UserName = username,
                    Password = pwd
                }, requestUri);

                var result = JsonHelper.Instance.Deserialize<LoginResult>(value);
                if (result.Success)
                {
                    return result.Token;
                }
                else
                {
                    return string.Empty;
                }
            }
            catch (Exception ex)
            {
                return string.Empty;
            }
        }

        public static bool Logout()
        {
            var tokenCookie = HttpContext.Current.Request.Cookies["Token"];
            if (tokenCookie == null) return true;

            string token = tokenCookie.Value;
            var requestUri = string.Format("/SSO/Login/Logout?token={0}&requestid={1}", token, "");

            try
            {
                var value = _helper.Post(requestUri);

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}