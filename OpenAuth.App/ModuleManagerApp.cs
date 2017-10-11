using System;
using Infrastructure;
using OpenAuth.Domain;
using System.Collections.Generic;
using System.Web;
using OpenAuth.App.SSO;
using OpenAuth.Domain.Service;

namespace OpenAuth.App
{
    public class ModuleManagerApp
    {
        private ModuleManService _moduleManService;

        public ModuleManagerApp(ModuleManService moduleManService)
        {
            _moduleManService = moduleManService;
        }

        /// <summary>
        /// 加载一个节点下面的所有
        /// </summary>
        public dynamic Load(string parentId, int pageindex, int pagesize)
        {
            return _moduleManService.Load(AuthUtil.GetUserName(), parentId, pageindex, pagesize);
        }

        public void Delete(string id)
        {
            _moduleManService.Delete(id);
        }

        public void AddOrUpdate(Module vm)
        {
            Module model = new Module();
            vm.CopyTo(model);  //copy一次，防止成员为null的情况
           _moduleManService.AddOrUpdate(model);
        }

        #region 用户/角色分配模块

        /// <summary>
        /// 加载特定用户的模块
        /// TODO:这里会加载用户及用户角色的所有模块，“为用户分配模块”功能会给人一种混乱的感觉，但可以接受
        /// </summary>
        /// <param name="userId">The user unique identifier.</param>
        public List<Module> LoadForUser(string userId)
        {
            return _moduleManService.LoadForUser(userId);
        }

        /// <summary>
        /// 加载特定角色的模块
        /// </summary>
        /// <param name="roleId">The role unique identifier.</param>
        public List<Module> LoadForRole(string roleId)
        {
            return _moduleManService.LoadForRole(roleId);
        }

        #endregion 用户/角色分配模块

    }
}