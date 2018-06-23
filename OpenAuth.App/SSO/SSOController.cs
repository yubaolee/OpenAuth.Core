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

using System;
using System.Web;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using OpenAuth.App.Interface;

namespace OpenAuth.App.SSO
{
    public class SSOController : Controller
    {
        public const string Token = "Token";

        protected IAuth _authUtil;

        public SSOController(IAuth authUtil)
        {
            _authUtil = authUtil;
        }

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var token = "";

            //Token by QueryString
            var request = filterContext.HttpContext.Request;
            if (request.Cookies[Token] != null)  //从Cookie读取Token
            {
                token = request.Cookies[Token];
            }

            if (string.IsNullOrEmpty(token))
            {
                //直接登录
                filterContext.Result = LoginResult("");
                return;
            }
            //验证
            if (_authUtil.CheckLogin(token, request.Path) == false)
            {
                //会话丢失，跳转到登录页面
                filterContext.Result = LoginResult("");
                return;
            }

            base.OnActionExecuting(filterContext);
        }

        public virtual ActionResult LoginResult(string username)
        {
            return new RedirectResult("/Login/Index");
        }
    }
}