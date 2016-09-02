using System;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;

namespace OpenAuth.App
{
    public class CategoryManagerApp
    {
        private ICategoryRepository _repository;
        private IOrgRepository _orgRepository;

        public CategoryManagerApp(ICategoryRepository repository,
            IOrgRepository orgRepository)
        {
            _repository = repository;
            _orgRepository = orgRepository;
        }

        public int GetCategoryCntInOrg(Guid orgId)
        {
            if (orgId == Guid.Empty)
            {
                return _repository.Find(null).Count();
            }
            else
            {
                return _repository.GetCategoryCntInOrgs(GetSubCategories(orgId));
            }
        }

        public List<Category> LoadAll()
        {
            return _repository.Find(null).ToList();
        }

        /// <summary>
        /// 加载一个部门及子部门全部Categorys
        /// </summary>
        public dynamic Load(Guid parentId, int pageindex, int pagesize)
        {
            IEnumerable<Category> Categorys;
            int total = 0;
            if (parentId == Guid.Empty)
            {
                Categorys = _repository.LoadCategorys(pageindex, pagesize);
                total = _repository.GetCount();
            }
            else
            {
                var ids = GetSubCategories(parentId);
                Categorys = _repository.LoadInOrgs(pageindex, pagesize, ids);
                total = _repository.GetCategoryCntInOrgs(ids);
            }

            return new
            {
                total = total,
                list = Categorys,
                pageCurrent = pageindex
            };
        }

        /// <summary>
        /// 获取当前组织的所有下级组织
        /// </summary>
        private Guid[] GetSubCategories(Guid orgId)
        {
            var category  = Find(orgId);
            var categories = _repository.Find(u => u.CascadeId.Contains(category.CascadeId)).Select(u => u.Id).ToArray();
            return categories;
        }

        public Category Find(Guid id)
        {
            var category = _repository.FindSingle(u => u.Id == id);
            if (category == null) return new Category();

            return category;
        }

        public void Delete(Guid id)
        {
            _repository.Delete(id);
        }

        public void AddOrUpdate(Category model)
        {
            Category category  = new Category();
            model.CopyTo(category);
            ChangeModuleCascade(category);

            if (category.Id == Guid.Empty)
            {
                _repository.Add(category);
            }
            else
            {
                _repository.Update(category);
            }
        }

        #region 私有方法

        //修改对象的级联ID，生成类似XXX.XXX.X.XX
        private void ChangeModuleCascade(Category org)
        {
            string cascadeId;
            int currentCascadeId = 1;  //当前结点的级联节点最后一位
            var sameLevels = _repository.Find(o => o.ParentId == org.ParentId && o.Id != org.Id);
            foreach (var obj in sameLevels)
            {
                int objCascadeId = int.Parse(obj.CascadeId.Split('.').Last());
                if (currentCascadeId <= objCascadeId) currentCascadeId = objCascadeId + 1;
            }

            if (org.ParentId != Guid.Empty)
            {
                var parentOrg = _repository.FindSingle(o => o.Id == org.ParentId);
                if (parentOrg != null)
                {
                    cascadeId = parentOrg.CascadeId + "." + currentCascadeId;
                }
                else
                {
                    throw new Exception("未能找到该组织的父节点信息");
                }
            }
            else
            {
                cascadeId = "0." + currentCascadeId;
            }

            org.CascadeId = cascadeId;
        }

        #endregion 私有方法
    }
}