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

using Infrastructure.Helper;
using OpenAuth.App.ViewModel;
using OpenAuth.Mvc.Models;
using System;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class BaseController : Controller
    {
        protected BjuiResponse BjuiResponse = new BjuiResponse();

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var loginUser = SessionHelper.GetSessionUser<LoginUserVM>();
            if (loginUser == null)
            {
                filterContext.Result = new RedirectResult("/Login/Index");
                return;
            }
            var controllername = Request.RequestContext.RouteData.Values["controller"].ToString().ToLower();
            var actionname = filterContext.ActionDescriptor.ActionName.ToLower();

            var function = this.GetType().GetMethods().FirstOrDefault(u => u.Name.ToLower() == actionname);
            if (function == null)
                throw new Exception("未能找到Action");

            var anonymous = function.GetCustomAttribute(typeof(AnonymousAttribute));
            var module = loginUser.Modules.FirstOrDefault(u => u.Url.ToLower().Contains(controllername));
            //当前登录用户没有Action记录&&Action没有anonymous标识
            if (module == null && anonymous == null)
            {
                filterContext.Result = new RedirectResult("/Login/Index");
                return;
            }
            else
            {
                ViewBag.Module = module;  //为View显示服务，主要是为了显示按钮
            }

            base.OnActionExecuting(filterContext);
        }
    }
}