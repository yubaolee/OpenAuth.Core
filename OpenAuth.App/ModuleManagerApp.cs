using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    public class ModuleManagerApp : BaseTreeApp<Module>
    {
        private RevelanceManagerApp _revelanceApp;

        public void Add(Module model)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            CaculateCascade(model);

            Repository.Add(model);

            AddDefaultMenus(model);
            //当前登录用户的所有角色自动分配模块
            loginContext.Roles.ForEach(u =>
            {
                _revelanceApp.Assign(new AssignReq
                {
                    type = Define.ROLEMODULE,
                    firstId = u.Id,
                    secIds = new[] {model.Id}
                });
            });
        }

        public void Update(Module obj)
        {
            UpdateTreeObj(obj);
        }


        #region 用户/角色分配模块

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

        //获取角色可访问的模块字段
        public IEnumerable<string> LoadPropertiesForRole(string roleId, string moduleCode)
        {
            return _revelanceApp.Get(Define.ROLEDATAPROPERTY, roleId, moduleCode);
        }

        /// <summary>
        /// 根据某角色ID获取可访问某模块的菜单项
        /// </summary>
        public IEnumerable<ModuleElement> LoadMenusForRole(string moduleId, string roleId)
        {
            var elementIds = _revelanceApp.Get(Define.ROLEELEMENT, true, roleId);
            var query = UnitWork.Find<ModuleElement>(u => elementIds.Contains(u.Id));
            if (!string.IsNullOrEmpty(moduleId))
            {
                query = query.Where(u => u.ModuleId == moduleId);
            }

            return query;
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
            UnitWork.Save();
        }


        /// <summary>
        /// 新增菜单
        /// <para>当前登录用户的所有角色会自动分配菜单</para>
        /// </summary>
        public void AddMenu(ModuleElement model)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            UnitWork.ExecuteWithTransaction(() =>
            {
                UnitWork.Add(model);

                //当前登录用户的所有角色自动分配菜单
                loginContext.Roles.ForEach(u =>
                {
                    _revelanceApp.Assign(new AssignReq
                    {
                        type = Define.ROLEELEMENT,
                        firstId = u.Id,
                        secIds = new[] {model.Id}
                    });
                });
                UnitWork.Save();
            });
        }

        public void UpdateMenu(ModuleElement model)
        {
            UnitWork.Update<ModuleElement>(model);
            UnitWork.Save();
        }

        //添加默认按钮
        private void AddDefaultMenus(Module module)
        {
            AddMenu(new ModuleElement
            {
                ModuleId = module.Id,
                DomId = "btnAdd",
                Script = "add()",
                Name = "添加",
                Sort = 1,
                Icon = "xinzeng",
                Class = "success",
                Remark = "新增" + module.Name
            });
            AddMenu(new ModuleElement
            {
                ModuleId = module.Id,
                DomId = "btnEdit",
                Script = "edit()",
                Name = "编辑",
                Sort = 2,
                Icon = "bianji-copy",
                Class = "primary",
                Remark = "修改" + module.Name
            });
            AddMenu(new ModuleElement
            {
                ModuleId = module.Id,
                DomId = "btnDel",
                Script = "del()",
                Name = "删除",
                Sort = 3,
                Icon = "shanchu",
                Class = "danger",
                Remark = "删除" + module.Name
            });

            //todo:可以自己添加更多默认按钮
        }

        #endregion


        public ModuleManagerApp(IUnitWork unitWork, IRepository<Module> repository
            , RevelanceManagerApp app, IAuth auth) : base(unitWork, repository, auth)
        {
            _revelanceApp = app;
        }
    }
}