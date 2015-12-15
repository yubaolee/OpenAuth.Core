
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
                Categorys = _repository.LoadInOrgs(pageindex, pagesize,GetSubOrgIds(orgId));
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
            Category category = model;
            if (category.Id == 0)
            {
                _repository.Add(category);
            }
            else
            {
                _repository.Update(category);
            }
           
        }

       
    }
}