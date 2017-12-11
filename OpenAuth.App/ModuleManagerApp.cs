using System.Collections.Generic;
using System.Linq;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    public class ModuleManagerApp :BaseApp<Module>
    {
        public void Add(Module model)
        {
            ChangeModuleCascade(model);
            Repository.Add(model);
        }

        public void Update(Module model)
        {
            ChangeModuleCascade(model);
            Repository.Update(u =>u.Id, model);
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


        #region 菜单操作
        /// <summary>
        /// 删除指定的菜单
        /// </summary>
        /// <param name="ids"></param>
        public void DelMenu(string[] ids)
        {
            UnitWork.Delete<ModuleElement>(u => ids.Contains(u.Id));
        }

        public void AddMenu(ModuleElement model)
        {
            UnitWork.Add(model);
        }
        #endregion



    }
}