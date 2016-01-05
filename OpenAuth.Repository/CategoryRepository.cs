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

        public IEnumerable<Category> LoadInOrgs(params int[] orgId)
        {
            var result = from category in Context.Categories where orgId.Contains(category.Id)
                select category;
            return result;

        }

        public int GetCategoryCntInOrgs(params int[] orgIds)
        {
            return LoadInOrgs(orgIds).Count();
        }

        public IEnumerable<Category> LoadInOrgs(int pageindex, int pagesize, params int[] orgIds)
        {
            return LoadInOrgs(orgIds).OrderBy(u =>u.Id).Skip((pageindex -1)*pagesize).Take(pagesize);
        }

        public void Delete(int id)
        {
            Delete(u =>u.Id == id);
        }
    }
}
