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
          public IUnitWork _unitWork { get; set; }

        public CategoryManagerApp(IUnitWork unitWork)
        {
            _unitWork = unitWork;
        }


        public List<Category> LoadAll()
        {
            return _unitWork.Find<Category>(null).ToList();
        }

        /// <summary>
        /// 加载一个分类及子分类全部Categorys
        /// </summary>
        public GridData Load(string parentId, int pageindex, int pagesize)
        {
            IQueryable<Category> categories;
            int total = 0;
            if (parentId == string.Empty)
            {
                categories = _unitWork.Find<Category>(pageindex, pagesize);
                total = _unitWork.GetCount<Category>();
            }
            else
            {
                var ids = GetSubCategories(parentId);
                categories = _unitWork.Find<Category>(pageindex, pagesize, "SortNo", u => ids.Contains(u.Id));
              //  total = _repository.GetCategoryCntInOrgs(ids);
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
                            c.Status,
                            c.Id
                        };
            return new GridData()
            {
                count = total,
                data = query.ToList()
            };
        }

        /// <summary>
        /// 获取当前组织的所有下级组织
        /// </summary>
        private string[] GetSubCategories(string orgId)
        {
            var category = Find(orgId);
            var categories = _unitWork.Find<Category>(u => u.CascadeId.Contains(category.CascadeId)).Select(u => u.Id).ToArray();
            return categories;
        }

        public Category Find(string id)
        {
            var category = _unitWork.FindSingle<Category>(u => u.Id == id);
            if (category == null) return new Category();

            return category;
        }

        public void Delete(string[] ids)
        {
            _unitWork.Delete<Category>(u =>ids.Contains(u.Id));
        }

        public void AddOrUpdate(Category model)
        {
            Category category = new Category();
            model.CopyTo(category);
            ChangeModuleCascade(category);

            if (category.Id == string.Empty)
            {
                _unitWork.Add(category);
            }
            else
            {
                //获取旧的的CascadeId
                var CascadeId = _unitWork.FindSingle<Category>(o => o.Id == category.Id).CascadeId;
                //根据CascadeId查询子分类
                var categorys = _unitWork.Find<Category>(u => u.CascadeId.Contains(CascadeId) && u.Id != category.Id).OrderBy(u => u.CascadeId).ToList();

                _unitWork.Update(category);

                //更新子分类的CascadeId
                foreach (var a in categorys)
                {
                    ChangeModuleCascade(a);
                    _unitWork.Update(a);
                }
                _unitWork.Save();
            }
        }

        #region 私有方法

        //修改对象的级联ID，生成类似XXX.XXX.X.XX
        private void ChangeModuleCascade(Category org)
        {
            string cascadeId;
            int currentCascadeId = 1;  //当前结点的级联节点最后一位
            var sameLevels = _unitWork.Find<Category>(o => o.ParentId == org.ParentId && o.Id != org.Id);
            foreach (var obj in sameLevels)
            {
                int objCascadeId = int.Parse(obj.CascadeId.TrimEnd('.').Split('.').Last());
                if (currentCascadeId <= objCascadeId) currentCascadeId = objCascadeId + 1;
            }

            if (org.ParentId != null && org.ParentId != string.Empty)
            {
                var parentOrg = _unitWork.FindSingle<Category>(o => o.Id == org.ParentId);
                if (parentOrg != null)
                {
                    cascadeId = parentOrg.CascadeId  + currentCascadeId +".";
                }
                else
                {
                    throw new Exception("未能找到该组织的父节点信息");
                }
            }
            else
            {
                cascadeId = ".0." + currentCascadeId +".";
            }

            org.CascadeId = cascadeId;
        }

        #endregion 私有方法
    }
}