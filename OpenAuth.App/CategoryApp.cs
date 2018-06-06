using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    /// <summary>
    /// 分类管理
    /// </summary>
    public class CategoryApp:BaseApp<Category>
    {

        public IEnumerable<Category> Get(string type)
        {
            return Repository.Find(u => u.TypeId == type);
        }

        public void Add(Category category)
        {
            if (string.IsNullOrEmpty(category.Id))
            {
                category.Id = Guid.NewGuid().ToString();
            }
            Repository.Add(category);
        }

        public void Update(Category category)
        {
            Repository.Update(u =>u.Id,category);
        }


        public TableData All(QueryCategoriesReq request)
        {
            var result = new TableData();
            var categories =  UnitWork.Find<Category>(null) ;
            if (!string.IsNullOrEmpty(request.key))
            {
                categories = categories.Where(u => u.Name.Contains(request.key) || u.Id.Contains(request.key));
            }

            if (!string.IsNullOrEmpty(request.TypeId))
            {
                categories = categories.Where(u => u.TypeId == request.TypeId);
            }

            var  query = from category in categories
                    join ct in UnitWork.Find<CategoryType>(null) on category.TypeId equals ct.Id
                    into tmp
                from ct in tmp.DefaultIfEmpty()
                select new
                {
                    category.Name,
                    category.Id,
                    category.TypeId,
                    TypeName = ct.Name,
                    category.Description
                };

            result.data = query.OrderBy(u => u.TypeId)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).ToList();
            result.count = categories.Count();
            return result;
        }

        public List<CategoryType> AllTypes()
        {
            return UnitWork.Find<CategoryType>(null).ToList();
        }
    }
}