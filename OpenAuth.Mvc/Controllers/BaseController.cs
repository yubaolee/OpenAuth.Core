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
// <summary>基础控制器，设置权限</summary>
// ***********************************************************************

using Infrastructure.Helper;
using OpenAuth.App.ViewModel;
using OpenAuth.Mvc.Models;
using System.Linq;
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

            if (controllername != "home")  //主页控制器无需权限控制
            {
                var module = loginUser.Modules.FirstOrDefault(u => u.Url.ToLower().Contains(controllername));
                if (module == null)
                {
                    filterContext.Result = new RedirectResult("/Login/Index");
                    return;
                }
                else
                {
                    ViewBag.Module = module;  //为View显示服务，主要是为了显示按钮
                }
            }

            base.OnActionExecuting(filterContext);
        }
    }
}