// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : Yubao Li
// Created          : 12-02-2015
//
// Last Modified By : Yubao Li
// Last Modified On : 12-02-2015
// ***********************************************************************
// <copyright file="ModuleElementManagerController.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>模块元素管理，无需权限控制</summary>
// ***********************************************************************

using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc.Controllers
{
    public class ModuleElementManagerController : Controller
    {
        private readonly BjuiResponse _bjuiResponse = new BjuiResponse();
        private ModuleElementManagerApp _app;

        public ModuleElementManagerController()
        {
            _app = (ModuleElementManagerApp) DependencyResolver.Current.GetService(typeof (ModuleElementManagerApp));
        }

        public ActionResult Index(int id = 0)
        {
            ViewBag.ModuleId = id;
            return View(_app.LoadByModuleId(id));
        }

        [HttpPost]
        public string AddOrEditButton(ModuleElement button)
        {
            try
            {
                var newbtn = new ModuleElement();
                button.CopyTo(newbtn);
                _app.AddOrUpdate(newbtn);
            }
            catch (DbEntityValidationException e)
            {
                _bjuiResponse.statusCode = "300";
                _bjuiResponse.message = e.Message;
            }
            return JsonHelper.Instance.Serialize(_bjuiResponse);
        }

        public string DelButton(int id)
        {
            try
            {
                _app.Delete(id);
            }
            catch (Exception e)
            {
                _bjuiResponse.statusCode = "300";
                _bjuiResponse.message = e.Message;
            }
            return JsonHelper.Instance.Serialize(_bjuiResponse);
        }

        #region 为角色分配菜单

        public ActionResult AssignForRole(int roleId)
        {
            ViewBag.RoleId = roleId;
            return View();
        }

        public string Load(int roleId, int orgId)
        {
            return JsonHelper.Instance.Serialize(_app.LoadWithAccess("RoleElement", roleId, orgId));
        }
        #endregion
    }
}