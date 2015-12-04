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

            string url = Request.Url.LocalPath;
            if (url != "/"
                && !url.Contains("Main")
                && !url.Contains("Error")
                && !url.Contains("Git"))
            {
                var module = loginUser.Modules.FirstOrDefault(u => url.Contains(u.Url));
                if (module == null)
                {
                    filterContext.Result = new RedirectResult("/Login/Index");
                    return;
                }
                else
                {
                    ViewBag.Module = module;
                }
            }
            base.OnActionExecuting(filterContext);
        }
    }
}