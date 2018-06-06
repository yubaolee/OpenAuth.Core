using System.Collections.Generic;
using System.Linq;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    public class ModuleManagerApp :BaseApp<Module>
    {
        public RevelanceManagerApp RevelanceManagerApp { get; set; }
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
        public IEnumerable<Module> LoadForUser(string userId)
        {
            var roleIds = RevelanceManagerApp.Get(Define.USERROLE, true, userId);
            var moduleIds = UnitWork.Find<Relevance>(
                u =>
                    (u.FirstId == userId && u.Key == Define.USERMODULE) ||
                    (u.Key == Define.ROLEMODULE && roleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            return UnitWork.Find<Module>(u => moduleIds.Contains(u.Id)).OrderBy(u => u.SortNo);
        }

        /// <summary>
        /// 根据某用户ID获取可访问某模块的菜单项
        /// </summary>
        /// <param name="moduleId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public IEnumerable<ModuleElement> LoadMenusForUser(string moduleId, string userId)
        {
            var elementIds = RevelanceManagerApp.Get(Define.USERELEMENT, true, userId);
            return UnitWork.Find<ModuleElement>(u => elementIds.Contains(u.Id) && u.ModuleId == moduleId);
        }

        /// <summary>
        /// 加载特定角色的模块
        /// </summary>
        /// <param name="roleId">The role unique identifier.</param>
        public IEnumerable<Module> LoadForRole(string roleId)
        {
            var moduleIds = UnitWork.Find<Relevance>(u => u.FirstId == roleId && u.Key == Define.ROLEMODULE)
                .Select(u => u.SecondId);
            return UnitWork.Find<Module>(u => moduleIds.Contains(u.Id)).OrderBy(u => u.SortNo);
        }

        public IEnumerable<ModuleElement> LoadMenusForRole(string moduleId, string roleId)
        {
            var elementIds = RevelanceManagerApp.Get(Define.ROLEELEMENT, true, roleId);
            return UnitWork.Find<ModuleElement>(u => elementIds.Contains(u.Id) && u.ModuleId == moduleId);

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
            UnitWork.Save();
        }
        #endregion

        public void UpdateMenu(ModuleElement model)
        {
            UnitWork.Update<ModuleElement>(u =>u.Id, model);
            UnitWork.Save();
        }
    }
}