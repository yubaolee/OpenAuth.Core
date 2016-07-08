using System.Web;
using System.Web.Mvc;

namespace OpenAuth.App.SSO
{
    public class SSOAuthAttribute : ActionFilterAttribute
    {
        public const string Token = "Token";
        public const string SessionUserName = "SessionUserName";

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var token = "";
            var cookieSessionUserName = "";

            //Token by QueryString
            var request = filterContext.HttpContext.Request;
            if (request.QueryString[Token] != null)
            {
                token = request.QueryString[Token];
                filterContext.HttpContext.Response.Cookies.Add(new HttpCookie(Token, token));
            }
            else if (request.Cookies[Token] != null)  //从Cookie读取Token
            {
                token = request.Cookies[Token].Value;
            }

            //SessionUserName by QueryString
            if (request.QueryString[SessionUserName] != null)
            {
                cookieSessionUserName = request.QueryString[SessionUserName];
                filterContext.HttpContext.Response.Cookies.Add(new HttpCookie(SessionUserName, cookieSessionUserName));
            }
            else if (request.Cookies[SessionUserName] != null)  //从Cookie读取SessionUserName
            {
                cookieSessionUserName = request.Cookies[SessionUserName].Value;
            }
            
            if (string.IsNullOrEmpty(token))
            {
                //直接登录
                filterContext.Result = SsoLoginResult(cookieSessionUserName);
            }
            else
            {
                //验证
                if (AuthUtil.CheckLogin(token, request.RawUrl) == false)
                {
                    //会话丢失，跳转到登录页面
                    filterContext.Result = SsoLoginResult(cookieSessionUserName);
                }
            }

            base.OnActionExecuting(filterContext);
        }

        private static ActionResult SsoLoginResult(string username)
        {
            //跳转到SSO站点登陆
            //return new RedirectResult(string.Format("{0}/sso/login?appkey={1}&username={2}",
            //        ConfigurationManager.AppSettings["SSOPassport"],
            //        ConfigurationManager.AppSettings["SSOAppKey"],
            //        username));

            return new RedirectResult("/Login/Index");
        }
    }
}
