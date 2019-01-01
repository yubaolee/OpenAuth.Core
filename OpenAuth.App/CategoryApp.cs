using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class CategoryApp : BaseApp<Category>
    {
        private RevelanceManagerApp _revelanceApp;

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QueryCategoryListReq request)
        {
             return new TableData
            {
                count = Repository.GetCount(null),
                data = Repository.Find(request.page, request.limit, "Id desc")
            };
        }

        public void Add(Category obj)
        {
            Repository.Add(obj);
        }
        
        public void Update(Category obj)
        {
            UnitWork.Update<Category>(u => u.Id == obj.Id, u => new Category
            {
               //todo:要修改的字段赋值
            });

        }

        public TableData All(QueryCategoryListReq request)
        {
            var result = new TableData();
            var categories = UnitWork.Find<Category>(null);
            if (!string.IsNullOrEmpty(request.key))
            {
                categories = categories.Where(u => u.Name.Contains(request.key) || u.Id.Contains(request.key));
            }

            if (!string.IsNullOrEmpty(request.TypeId))
            {
                categories = categories.Where(u => u.TypeId == request.TypeId);
            }

            var query = from category in categories
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

        public CategoryApp(IUnitWork unitWork, IRepository<Category> repository,
            RevelanceManagerApp app) : base(unitWork, repository)
        {
            _revelanceApp = app;
        }
    }
}