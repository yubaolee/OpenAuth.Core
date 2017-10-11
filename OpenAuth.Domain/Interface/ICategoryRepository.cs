using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Interface
{
    public interface ICategoryRepository :IRepository<Category>
    {
        IEnumerable<Category> LoadCategorys(int pageindex, int pagesize);

        IEnumerable<Category> LoadInOrgs(params string[] orgId);
        int GetCategoryCntInOrgs(params string[] orgIds);
        IEnumerable<Category> LoadInOrgs(int pageindex, int pagesize, params string[] orgIds);

        /// <summary>
        /// 获取子分类ID
        /// </summary>
        string[] GetSubIds(string orgId);

        void Delete(string id);

    }
}