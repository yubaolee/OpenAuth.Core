// ***********************************************************************
// Assembly         : OpenAuth.Mvc
// Author           : 李玉宝
// Created          : 06-08-2018
//
// Last Modified By : 李玉宝
// Last Modified On : 07-04-2018
// ***********************************************************************
// <copyright file="UserSessionController.cs" company="OpenAuth.Mvc">
//     Copyright (c) http://www.openauth.me. All rights reserved.
// </copyright>
// <summary>
// 获取登录用户的全部信息
// 所有和当前登录用户相关的操作都在这里
// </summary>
// ***********************************************************************

using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.Interface;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Mvc.Controllers
{
    public class UserSessionController : BaseController
    {
        private readonly AuthStrategyContext _authStrategyContext;
        public UserSessionController(IAuth authUtil) : base(authUtil)
        {
            _authStrategyContext = _authUtil.GetCurrentUser();
        }

        /// <summary>
        /// 获取用户资料
        /// </summary>
        /// <returns></returns>
        public string GetUserProfile()
        {
            var resp = new Response<UserView>();
            try
            {
                resp.Result = _authStrategyContext.User.MapTo<UserView>();
            }
            catch (Exception e)
            {
                resp.Code = 500;
                resp.Message = e.Message;
            }
            return JsonHelper.Instance.Serialize(resp);
        }

        public string GetUserName()
        {
            return _authUtil.GetUserName();
        }
        /// <summary>
        /// 获取登录用户可访问的所有模块，及模块的操作菜单
        /// </summary>
        public string GetModulesTree()
        {
            var moduleTree = _authStrategyContext.Modules.GenerateTree(u => u.Id, u => u.ParentId);
            return JsonHelper.Instance.Serialize(moduleTree);
        }

        /// <summary>
        /// datatable结构的模块列表
        /// </summary>
        /// <param name="pId"></param>
        /// <returns></returns>
        public string GetModulesTable(string pId)
        {
            string cascadeId = ".0.";
            if (!string.IsNullOrEmpty(pId))
            {
                var obj = _authStrategyContext.Modules.SingleOrDefault(u => u.Id == pId);
                if (obj == null)
                    throw new Exception("未能找到指定对象信息");
                cascadeId = obj.CascadeId;
            }

            var query = _authStrategyContext.Modules.Where(u => u.CascadeId.Contains(cascadeId));

            return JsonHelper.Instance.Serialize(new TableData
            {
                data = query.ToList(),
                count = query.Count(),
            });

        }

        /// <summary>
        /// 获取用户可访问的模块列表
        /// </summary>
        public string GetModules()
        {
            var resp = new Response<List<ModuleView>>();
            try
            {
                resp.Result = _authStrategyContext.Modules;
            }
            catch (Exception e)
            {
                resp.Code = 500;
                resp.Message = e.Message;
            }
            return JsonHelper.Instance.Serialize(resp);
        }

        /// <summary>
        /// 获取登录用户可访问的所有部门
        /// <para>用于树状结构</para>
        /// </summary>
        public string GetOrgs()
        {
             var resp = new Response<List<Org>>();
            try
            {
                resp.Result = _authStrategyContext.Orgs;
            }
            catch (Exception e)
            {
                resp.Code = 500;
                resp.Message = e.Message;
            }
            return JsonHelper.Instance.Serialize(resp);
        }

        /// <summary>
        /// 获取当前登录用户可访问的字段
        /// </summary>
        /// <param name="moduleCode">模块的Code，如Category</param>
        /// <returns></returns>
        public string GetProperties(string moduleCode)
        {
            try
            {
                var list = _authStrategyContext.GetProperties(moduleCode);
                return JsonHelper.Instance.Serialize(new TableData
                {
                    data = list,
                    count = list.Count(),
                });
            }
            catch (Exception ex)
            {
                return JsonHelper.Instance.Serialize(new TableData
                    {
                        msg =ex.Message,
                        code = 500,
                    });
            }
        }

        /// <summary>
        /// 加载机构的全部下级机构
        /// </summary>
        /// <param name="orgId">机构ID</param>
        /// <returns></returns>
        public string GetSubOrgs(string orgId)
        {
            string cascadeId = ".0.";
            if (!string.IsNullOrEmpty(orgId))
            {
                var org = _authStrategyContext.Orgs.SingleOrDefault(u => u.Id == orgId);
                if (org == null)
                {
                    return JsonHelper.Instance.Serialize(new TableData
                    {
                        msg ="未找到指定的节点",
                        code = 500,
                    });
                }
                cascadeId = org.CascadeId;
            }

            var query = _authStrategyContext.Orgs.Where(u => u.CascadeId.Contains(cascadeId));

            return JsonHelper.Instance.Serialize(new TableData
            {
                data = query.ToList(),
                count = query.Count(),
            });
        }

    }
}