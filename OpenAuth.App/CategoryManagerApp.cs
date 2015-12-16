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

        public int GetCategoryCntInOrg(int orgId)
        {
            if (orgId == 0)
            {
                return _repository.Find(null).Count();
            }
            else
            {
                return _repository.GetCategoryCntInOrgs(GetSubOrgIds(orgId));
            }
        }

        public List<Category> LoadAll()
        {
            return _repository.Find(null).ToList();
        }

        /// <summary>
        /// 加载一个部门及子部门全部Categorys
        /// </summary>
        public dynamic Load(int orgId, int pageindex, int pagesize)
        {
            IEnumerable<Category> Categorys;
            int total = 0;
            if (orgId == 0)
            {
                Categorys = _repository.LoadCategorys(pageindex, pagesize);
                total = _repository.GetCount();
            }
            else
            {
                Categorys = _repository.LoadInOrgs(pageindex, pagesize, GetSubOrgIds(orgId));
                total = _repository.GetCategoryCntInOrgs(orgId);
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
        private int[] GetSubOrgIds(int orgId)
        {
            var org = _orgRepository.FindSingle(u => u.Id == orgId);
            var orgs = _orgRepository.Find(u => u.CascadeId.Contains(org.CascadeId)).Select(u => u.Id).ToArray();
            return orgs;
        }

        public Category Find(int id)
        {
            var category = _repository.FindSingle(u => u.Id == id);
            if (category == null) return new Category();

            return category;
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }

        public void AddOrUpdate(Category model)
        {
            Category category  = new Category();
            model.CopyTo(category);
            if (category.Id == 0)
            {
                ChangeModuleCascade(category);
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

            if (org.ParentId != 0)
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