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

using System.Web.Mvc;
using Infrastructure.Helper;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
	public class BaseController : Controller
	{
        protected BjuiResponse BjuiResponse = new BjuiResponse();

       
		protected override void OnActionExecuting(ActionExecutingContext filterContext)
		{
			base.OnActionExecuting(filterContext);

            //#region 当Session过期自动跳出登录画面
            if (SessionHelper.GetSessionUser<LoginUserVM>() == null)
            {
                Response.Redirect("/Login/Index");
            }
            //#endregion
		}
	}
}