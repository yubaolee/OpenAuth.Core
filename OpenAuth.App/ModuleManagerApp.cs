using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;

namespace OpenAuth.App
{
    public class ModuleManagerApp
    {
        private IModuleRepository _repository;

        public ModuleManagerApp(IModuleRepository repository)
        {
            _repository = repository;
        }

        /// <summary>
        /// 加载一个节点下面的所有
        /// </summary>
        public dynamic Load(int parentId, int pageindex, int pagesize)
        {
            IEnumerable<Module> Modules;
            int total = 0;
            if (parentId == 0)
            {
                Modules = _repository.LoadModules(pageindex, pagesize);
                total = _repository.GetCount();
            }
            else
            {
                Modules = _repository.LoadInOrgs(pageindex, pagesize, GetSubOrgIds(parentId));
                total = _repository.GetModuleCntInOrgs(parentId);
            }

            return new
            {
                total = total,
                list = Modules,
                pageCurrent = pageindex
            };
        }

        /// <summary>
        /// 为树型结构提供数据
        /// </summary>
        public List<Module> LoadForTree(bool bAll)
        {
            if (bAll)
                return _repository.Find(null).ToList();
            return _repository.Find(u => u.ParentId == 0).ToList();
        }

        /// <summary>
        /// 以组合的方式显示所有的模块信息
        /// </summary>
        /// <param name="parentId">The parent unique identifier.</param>
        /// <returns>List{ModuleView}.</returns>
        public List<ModuleView> LoadByParent(int parentId)
        {
            var modules = new List<ModuleView>();
            var roots = _repository.Find(u => u.ParentId == parentId);
            foreach (var module in roots)
            {
                ModuleView mv = module;
                mv.Childern = LoadByParent(module.Id);
                modules.Add(mv);
            }
            return modules;
        }

        public Module Find(int id)
        {
            var module = _repository.FindSingle(u => u.Id == id);
            if (module == null) return new Module();

            return module;
        }

        public void Delete(int id)
        {
            var del = _repository.FindSingle(u => u.Id == id);
            if (del == null) return;

            _repository.Delete(u => u.CascadeId.Contains(del.CascadeId));
        }

        public void AddOrUpdate(Module vm)
        {
            Module model = new Module();
            vm.CopyTo(model);  //copy一次，防止成员为null的情况
            ChangeModuleCascade(model);
            if (model.Id == 0)
            {
                _repository.Add(model);
            }
            else
            {
                _repository.Update(model);
            }
        }

        #region 私有方法

        //根据同一级中最大的语义ID

        private int[] GetSubOrgIds(int parentId)
        {
            var parent = _repository.FindSingle(u => u.Id == parentId);
            var orgs = _repository.Find(u => u.CascadeId.Contains(parent.CascadeId)).Select(u => u.Id).ToArray();
            return orgs;
        }

        //修改对象的级联ID
        private void ChangeModuleCascade(Module module)
        {
            string cascadeId;
            int currentCascadeId = 1;  //当前结点的级联节点最后一位
            var sameLevels = _repository.Find(o => o.ParentId == module.ParentId && o.Id != module.Id);
            foreach (var obj in sameLevels)
            {
                int objCascadeId = int.Parse(obj.CascadeId.Split('.').Last());
                if (currentCascadeId <= objCascadeId) currentCascadeId = objCascadeId + 1;
            }

            if (module.ParentId != 0)
            {
                var parentOrg = _repository.FindSingle(o => o.Id == module.ParentId);
                if (parentOrg != null)
                {
                    cascadeId = parentOrg.CascadeId + "." + currentCascadeId;
                    module.ParentName = parentOrg.Name;
                }
                else
                {
                    throw new Exception("未能找到该组织的父节点信息");
                }
            }
            else
            {
                cascadeId = "0." + currentCascadeId;
                module.ParentName = "根节点";
            }

            module.CascadeId = cascadeId;
        }

        #endregion 私有方法
    }
}