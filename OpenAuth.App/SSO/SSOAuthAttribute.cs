using System;
using System.Web;
using System.Web.Mvc;

namespace OpenAuth.App.SSO
{
    /// <summary>
    /// 采用Attribute的方式验证登陆
    /// <para>李玉宝新增于2016-11-09 10:08:10</para>
    /// </summary>
    public class SSOAuthAttribute : ActionFilterAttribute
    {
        public const string Token = "Token";

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var token = "";

            //Token by QueryString
            var request = filterContext.HttpContext.Request;
            if (request.QueryString[Token] != null)
            {
                token = request.QueryString[Token];
                var cookie = new HttpCookie(Token, token)
                {
                    Expires = DateTime.Now.AddDays(10)
                };
                filterContext.HttpContext.Response.Cookies.Add(cookie);
            }
            else if (request.Cookies[Token] != null)  //从Cookie读取Token
            {
                token = request.Cookies[Token].Value;
            }

            if (string.IsNullOrEmpty(token))
            {
                //直接登录
                filterContext.Result = LoginResult("");
                return;
            }
            else
            {
                //验证
                if (AuthUtil.CheckLogin(token, request.RawUrl) == false)
                {
                    //会话丢失，跳转到登录页面
                    filterContext.Result = LoginResult("");
                    return;
                }
            }

            base.OnActionExecuting(filterContext);
        }

        public virtual ActionResult LoginResult(string username)
        {
            return new RedirectResult("/Login/Index");
        }
    }
}
