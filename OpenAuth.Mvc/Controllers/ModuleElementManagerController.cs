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
            _app = AutofacExt.GetFromFac<ModuleElementManagerApp>();
        }

        public ActionResult Index(int id)
        {
            ViewBag.ModuleId = id;
            return View();
        }

        public ActionResult Get(int moduleId = 0)
        {
            return Json(_app.LoadByModuleId(moduleId));
        }

        [HttpPost]
        public string AddOrEditButton(ModuleElement button)
        {
            try
            {
                _app.AddOrUpdate(button);
            }
            catch (DbEntityValidationException e)
            {
                _bjuiResponse.statusCode = "300";
                _bjuiResponse.message = e.Message;
            }
            return JsonHelper.Instance.Serialize(_bjuiResponse);
        }

        public string Del(string moduleElements)
        {
            try
            {
                var delObjs = JsonHelper.Instance.Deserialize<ModuleElement[]>(moduleElements);
                _app.Delete(delObjs);
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

        /// <summary>
        /// 为角色分配菜单
        /// </summary>
        /// <param name="roleId">角色ID</param>
        /// <param name="moduleId">模块ID</param>
        /// <param name="menuIds">菜单ID列表</param>
        /// <returns></returns>
        [HttpPost]
        public string AssignForRole(int roleId, string menuIds)
        {
            try
            {
                var ids = JsonHelper.Instance.Deserialize<int[]>(menuIds);
                _app.AssignForRole(roleId, ids);
            }
            catch (Exception e)
            {
                _bjuiResponse.statusCode = "300";
                _bjuiResponse.message = e.Message;
            }
            return JsonHelper.Instance.Serialize(_bjuiResponse);
        }

        [HttpPost]
        public string CancelForRole(int roleId, string menuIds)
        {
            try
            {
                var ids = JsonHelper.Instance.Deserialize<int[]>(menuIds);
                _app.CancelForRole(roleId, ids);
            }
            catch (Exception e)
            {
                _bjuiResponse.statusCode = "300";
                _bjuiResponse.message = e.Message;
            }
            return JsonHelper.Instance.Serialize(_bjuiResponse);
        }

        public string LoadForRole(int roleId, int moduleId)
        {
            return JsonHelper.Instance.Serialize(_app.LoadWithAccess("RoleElement", roleId, moduleId));
        }
        #endregion

        #region 为用户分配菜单

        public ActionResult AssignForUser(int userId)
        {
            ViewBag.UserId = userId;
            return View();
        }
        /// <summary>
        /// 为用户分配菜单
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="menuIds">菜单ID列表</param>
        /// <returns></returns>
        [HttpPost]
        public string AssignForUser(int userId, string menuIds)
        {
            try
            {
                var ids = JsonHelper.Instance.Deserialize<int[]>(menuIds);
                _app.AssignForUser(userId, ids);
            }
            catch (Exception e)
            {
                _bjuiResponse.statusCode = "300";
                _bjuiResponse.message = e.Message;
            }
            return JsonHelper.Instance.Serialize(_bjuiResponse);
        }
        [HttpPost]
        public string CancelForUser(int userId, string menuIds)
        {
            try
            {
                var ids = JsonHelper.Instance.Deserialize<int[]>(menuIds);
                _app.CancelForUser(userId, ids);
            }
            catch (Exception e)
            {
                _bjuiResponse.statusCode = "300";
                _bjuiResponse.message = e.Message;
            }
            return JsonHelper.Instance.Serialize(_bjuiResponse);
        }

        public string LoadForUser(int userId, int moduleId)
        {
            return JsonHelper.Instance.Serialize(_app.LoadWithAccess("UserElement", userId, moduleId));
        }
        #endregion
    }
}