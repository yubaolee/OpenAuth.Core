
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.App
{
    public class ModuleManagerApp
    {
        private IModuleRepository _repository;

        public ModuleManagerApp(IModuleRepository repository)
        {
            _repository = repository;
        }

        public int GetModuleCntInOrg(int orgId)
        {
            if (orgId == 0)
            {
                return _repository.Find(null).Count();
            }
            else
            {
                return _repository.GetModuleCntInOrgs(GetSubOrgIds(orgId));
            }
        }

        /// <summary>
        /// 加载一个部门及子部门全部Modules
        /// </summary>
        public dynamic Load(int orgId, int pageindex, int pagesize)
        {
            IEnumerable<Module> Modules;
            int total = 0;
            if (orgId == 0)
            {
                Modules = _repository.LoadModules(pageindex, pagesize);
                total = _repository.GetCount();
            }
            else
            {
                Modules = _repository.LoadInOrgs(pageindex, pagesize,GetSubOrgIds(orgId));
                total = _repository.GetModuleCntInOrgs(orgId);
            }

            return new 
            {
                total = total,
                list = Modules,
                pageCurrent = pageindex
            };
        }

        public List<Module> LoadForTree(bool bAll)
        {
            if (bAll)
                return _repository.Find(null).ToList();
            return _repository.Find(u => u.ParentId == 0).ToList();
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

        public void AddOrUpdate(Module model)
        {
            Module module = model;
            if (module.Id == 0)
            {
                string cascadeId;
                int currentCascadeId = GetMaxCascadeId(module.ParentId);

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
                    module.ParentName = "";
                }

                module.CascadeId = cascadeId;
                _repository.Add(module);
            }
            else
            {
                _repository.Update(module);
            }
           
        }

        #region 私有方法

        //根据同一级中最大的语义ID
        private int GetMaxCascadeId(int parentId)
        {
            int currentCascadeId = 1;
            var sameLevels = _repository.Find(o => o.ParentId == parentId);
            foreach (var obj in sameLevels)
            {
                int objCascadeId = int.Parse(obj.CascadeId.Split('.').Last());
                if (currentCascadeId < objCascadeId) currentCascadeId = objCascadeId + 1;
            }

            return currentCascadeId;
        }

        private int[] GetSubOrgIds(int orgId)
        {
            var org = _repository.FindSingle(u => u.Id == orgId);
            var orgs = _repository.Find(u => u.CascadeId.Contains(org.CascadeId)).Select(u => u.Id).ToArray();
            return orgs;
        }

        #endregion 私有方法

       
    }
}