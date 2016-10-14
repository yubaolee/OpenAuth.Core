using Infrastructure;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.App
{
    public class CategoryManagerApp
    {
        private ICategoryRepository _repository;
        private IUnitWork _unitWork;

        public CategoryManagerApp(ICategoryRepository repository,
            IUnitWork unitWork)
        {
            _repository = repository;
            _unitWork = unitWork;
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
        /// 加载一个分类及子分类全部Categorys
        /// </summary>
        public GridData Load(Guid parentId, int pageindex, int pagesize)
        {
            IQueryable<Category> categories;
            int total = 0;
            if (parentId == Guid.Empty)
            {
                categories = _unitWork.Find<Category>(pageindex, pagesize);
                total = _repository.GetCount();
            }
            else
            {
                var ids = GetSubCategories(parentId);
                categories = _unitWork.Find<Category>(pageindex, pagesize, "SortNo", u => ids.Contains(u.Id));
                total = _repository.GetCategoryCntInOrgs(ids);
            }

            var query = from c in categories
                        join category in _unitWork.Find<Category>(null) on c.ParentId equals category.Id into temp
                        from category in temp.DefaultIfEmpty()
                        select new
                        {
                            c.CascadeId,
                            c.Name,
                            c.ParentId,
                            ParentName = category.Name,
                            c.SortNo,
                            c.RootName,
                            c.RootKey,
                            c.Status,
                            c.Id
                        };
            return new GridData()
            {
                records = total,
                total = (int)Math.Ceiling((double)total/pagesize),
                rows = query.ToList(),
                page = pageindex
            };
        }

        /// <summary>
        /// 获取当前组织的所有下级组织
        /// </summary>
        private Guid[] GetSubCategories(Guid orgId)
        {
            var category = Find(orgId);
            var categories = _repository.Find(u => u.CascadeId.Contains(category.CascadeId)).Select(u => u.Id).ToArray();
            return categories;
        }

        public Category Find(Guid id)
        {
            var category = _repository.FindSingle(u => u.Id == id);
            if (category == null) return new Category();

            return category;
        }

        public void Delete(Guid[] ids)
        {
            _repository.Delete(u =>ids.Contains(u.Id));
        }

        public void AddOrUpdate(Category model)
        {
            Category category = new Category();
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

            if (org.ParentId != null && org.ParentId != Guid.Empty)
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