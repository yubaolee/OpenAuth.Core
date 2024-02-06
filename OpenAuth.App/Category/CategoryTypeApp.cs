﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Infrastructure;
using Microsoft.EntityFrameworkCore;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class CategoryTypeApp : BaseStringApp<CategoryType,OpenAuthDBContext>
    {
        private RevelanceManagerApp _revelanceApp;

        /// <summary>
        /// 加载列表
        /// </summary>
        public async Task<TableData> Load(QueryCategoryTypeListReq request)
        {
            var result = new TableData();
            var objs = UnitWork.Find<CategoryType>(null);
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.Id.Contains(request.key) || u.Name.Contains(request.key));
            }
            
            result.data =await objs.OrderBy(u => u.Name)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).ToListAsync();
            result.count =await objs.CountAsync();
            return result;
        }

        public void Add(AddOrUpdateCategoryTypeReq req)
        {
            var obj = req.MapTo<CategoryType>();
            //todo:补充或调整自己需要的字段
            obj.CreateTime = DateTime.Now;
            Repository.Add(obj);
        }

         public void Update(AddOrUpdateCategoryTypeReq obj)
        {
            var user = _auth.GetCurrentUser().User;
            UnitWork.Update<CategoryType>(u => u.Id == obj.Id, u => new CategoryType
            {
                Name = obj.Name,
                CreateTime = DateTime.Now
                //todo:补充或调整自己需要的字段
            });

        }
         
         public new void Delete(string[] ids)
         {
             UnitWork.ExecuteWithTransaction(() =>
             {
                 UnitWork.Delete<CategoryType>(u=>ids.Contains(u.Id));
                 UnitWork.Delete<Category>(u=>ids.Contains(u.TypeId));
                 UnitWork.Save();
             });
          
         }
         
         public List<CategoryType> AllTypes()
         {
             return UnitWork.Find<CategoryType>(null).ToList();
         }

        public CategoryTypeApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<CategoryType,OpenAuthDBContext> repository,
            RevelanceManagerApp app, IAuth auth) : base(unitWork, repository,auth)
        {
            _revelanceApp = app;
        }
    }
}