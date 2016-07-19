// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : yubaolee
// Created          : 07-11-2016
//
// Last Modified By : yubaolee
// Last Modified On : 07-19-2016
// Contact : www.cnblogs.com/yubaolee
// File: BaseController.cs
// ***********************************************************************


using OpenAuth.Mvc.Models;
using System;
using System.Configuration;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using OpenAuth.App.SSO;

namespace OpenAuth.Mvc.Controllers
{
    /// <summary>
    /// 基础控制器
    /// <para>用于控制登录用户是否有权限访问指定的Action</para>
    /// <para>李玉宝新增于2016-07-19 11:12:09</para>
    /// </summary>
    public class BaseController : SSOController
    {
        protected BjuiResponse BjuiResponse = new BjuiResponse();

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            base.OnActionExecuting(filterContext);

            if (!AuthUtil.CheckLogin())  return;

            var controllername = Request.RequestContext.RouteData.Values["controller"].ToString().ToLower();
            var actionname = filterContext.ActionDescriptor.ActionName.ToLower();

            var function = this.GetType().GetMethods().FirstOrDefault(u => u.Name.ToLower() == actionname);
            if (function == null)
                throw new Exception("未能找到Action");

            var authorize = function.GetCustomAttribute(typeof(AuthenticateAttribute));
            var module = AuthUtil.GetCurrentUser().Modules.FirstOrDefault(u => u.Url.ToLower().Contains(controllername));
            //当前登录用户没有Action记录&&Action有authenticate标识
            if (authorize != null && module == null)
            {
                filterContext.Result = new RedirectResult("/Login/Index");
                return;
            }
            else
            {
                ViewBag.Module = module;  //为View显示服务，主要是为了显示按钮
            }

            var version = ConfigurationManager.AppSettings["version"];
            if (version == "demo")
            {
                HttpPostAttribute hobbyAttr = (HttpPostAttribute)Attribute.GetCustomAttribute(function, typeof(HttpPostAttribute));
                if (actionname.Contains("del") || hobbyAttr != null)  //客户端提交数据
                {
                    throw new HttpException(400, "演示版本，不能进行该操作，当前模块:" + controllername +"/" +actionname);
                }
            }
            
        }
    }
}