using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Repository
{
    public class CategoryRepository :BaseRepository<Category>, ICategoryRepository
    {

        public IEnumerable<Category> LoadCategorys(int pageindex, int pagesize)
        {
            return Context.Categories.OrderBy(u => u.Id).Skip((pageindex - 1) * pagesize).Take(pagesize);
        }

        public IEnumerable<Category> LoadInOrgs(params Guid[] orgId)
        {
            var result = from category in Context.Categories where orgId.Contains(category.Id)
                select category;
            return result;

        }

        public int GetCategoryCntInOrgs(params Guid[] orgIds)
        {
            return LoadInOrgs(orgIds).Count();
        }

        public IEnumerable<Category> LoadInOrgs(int pageindex, int pagesize, params Guid[] orgIds)
        {
            return LoadInOrgs(orgIds).OrderBy(u =>u.Id).Skip((pageindex -1)*pagesize).Take(pagesize);
        }

        public void Delete(Guid id)
        {
            Delete(u =>u.Id == id);
        }

        /// <summary>
        /// 获取当前节点的所有下级节点
        /// </summary>
        public Guid[] GetSubIds(Guid orgId)
        {
            if (orgId == Guid.Empty)
            {
                return Find(null).Select(u => u.Id).ToArray();
            }
            var org = FindSingle(u => u.Id == orgId);
            var ids = Find(u => u.CascadeId.Contains(org.CascadeId)).Select(u => u.Id).ToArray();
            return ids;
        }
    }
}
