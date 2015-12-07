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
using System.Linq;
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
        [HttpPost]
        public string AssignForRole(int roleId, string menuIds)
        {
            try
            {
                var ids = menuIds.Split(',').Select(id => int.Parse(id)).ToArray();
                _app.AssignForRole(roleId, ids);
            }
            catch (Exception e)
            {
                _bjuiResponse.statusCode = "300";
                _bjuiResponse.message = e.Message;
            }
            return JsonHelper.Instance.Serialize(_bjuiResponse);
        }

        public string LoadForRole(int roleId, int orgId)
        {
            return JsonHelper.Instance.Serialize(_app.LoadWithAccess("RoleElement", roleId, orgId));
        }
        #endregion

        #region 为用户分配菜单

        public ActionResult AssignForUser(int userId)
        {
            ViewBag.UserId = userId;
            return View();
        }
        [HttpPost]
        public string AssignForUser(int userId, string menuIds)
        {
            try
            {
                var ids = menuIds.Split(',').Select(id => int.Parse(id)).ToArray();
                _app.AssignForUser(userId, ids);
            }
            catch (Exception e)
            {
                _bjuiResponse.statusCode = "300";
                _bjuiResponse.message = e.Message;
            }
            return JsonHelper.Instance.Serialize(_bjuiResponse);
        }

        public string LoadForUser(int userId, int orgId)
        {
            return JsonHelper.Instance.Serialize(_app.LoadWithAccess("UserElement", userId, orgId));
        }
        #endregion
    }
}