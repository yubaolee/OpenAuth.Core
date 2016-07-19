// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : Administrator
// Created          : 09-22-2015
//
// Last Modified By : Administrator
// Last Modified On : 09-22-2015
// ***********************************************************************
// <copyright file="BaseController.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>
// 基础控制器
// 继承该控制器可以防止未登录查看
// 继承该控制器后，如果想访问控制器中存在，但模块配置里面没有的Action（如：Home/Git），请使用AnonymousAttribute
// </summary>
// ***********************************************************************

using System.Web;
using System.Web.Mvc;

namespace OpenAuth.App.SSO
{
    public class SSOController : Controller
    {
        public const string Token = "Token";
        public const string SessionUserName = "SessionUserName";

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
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
                filterContext.Result = LoginResult(cookieSessionUserName);
                return;
            }
            else
            {
                //验证
                if (AuthUtil.CheckLogin(token, request.RawUrl) == false)
                {
                    //会话丢失，跳转到登录页面
                    filterContext.Result = LoginResult(cookieSessionUserName);
                    return;
                }
            }

            base.OnActionExecuting(filterContext);
        }

        private static ActionResult LoginResult(string username)
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