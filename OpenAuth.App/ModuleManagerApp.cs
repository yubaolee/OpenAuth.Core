using OpenAuth.Domain;
using System.Collections.Generic;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    public class ModuleManagerApp
    {
          public IUnitWork _unitWork { get; set; }

        public void Delete(string id)
        {
          //  _unitWork.Delete<Module>(id);
        }

        public void AddOrUpdate(Module vm)
        {
         //  _moduleManService.AddOrUpdate(vm);
        }

        #region 用户/角色分配模块

        /// <summary>
        /// 加载特定用户的模块
        /// TODO:这里会加载用户及用户角色的所有模块，“为用户分配模块”功能会给人一种混乱的感觉，但可以接受
        /// </summary>
        /// <param name="userId">The user unique identifier.</param>
        public List<Module> LoadForUser(string userId)
        {
            return null;
        }

        /// <summary>
        /// 加载特定角色的模块
        /// </summary>
        /// <param name="roleId">The role unique identifier.</param>
        public List<Module> LoadForRole(string roleId)
        {
            return null;
        }

        #endregion 用户/角色分配模块

    }
}