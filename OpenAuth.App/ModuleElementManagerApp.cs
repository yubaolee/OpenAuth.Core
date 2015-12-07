// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : Yubao Li
// Created          : 12-02-2015
//
// Last Modified By : Yubao Li
// Last Modified On : 12-02-2015
// ***********************************************************************
// <copyright file="ModuleElementManagerApp.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>模块元素</summary>
// ***********************************************************************

using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    public class ModuleElementManagerApp
    {
        private readonly IRepository<ModuleElement> _repository;
        private IModuleRepository _moduleRepository;
        private IRelevanceRepository _relevanceRepository;

        public ModuleElementManagerApp(IRepository<ModuleElement> repository,
            IRelevanceRepository relevanceRepository,
            IModuleRepository  moduleRepository )
        {
            _repository = repository;
            _moduleRepository = moduleRepository;
            _relevanceRepository = relevanceRepository;
        }

        public void AddOrUpdate(ModuleElement model)
        {
            if (model.Id == 0)
            {
                _repository.Add(model);
            }
            else
            {
                _repository.Update(model);
            }
        }

        public IEnumerable<ModuleElement> LoadByModuleId(int id)
        {
            var modules = _repository.Find(u => u.ModuleId == id);
            return modules;
        }

        /// <summary>
        /// 获取带有授权状态的菜单列表
        /// </summary>
        /// <param name="accessType">授权类型，当前有RoleElement/UserElement</param>
        /// <param name="firstId">
        /// 当为RoleElement时，表示RoleId
        /// 当为UserElement时，表示UserId
        /// </param>
        /// <param name="moduleId">模块ID</param>
        public List<ModuleElementVM> LoadWithAccess(string accessType, int firstId, int moduleId)
        {
            //TODO:多个Repository使用的是不同的Context不能进行联表查询，要用UnitOfWork处理
            //var results = from element in _repository.Find(u => u.ModuleId == moduleId)
            //    join module in _moduleRepository.Find(null) on element.ModuleId equals module.Id
            //    join relev in _relevanceRepository.Find(u => u.Key == accessType && u.FirstId == firstId)
            //        on element.Id equals relev.SecondId into temp
            //    from t in temp.DefaultIfEmpty()
            //    select new ModuleElementVM
            //    {
            //        DomId = element.DomId,
            //        Id = element.Id,
            //        ModuleId = element.ModuleId,
            //        ModuleName = module.Name,
            //        Name = element.Name,
            //        Accessed = t != null
            //    };
            var listVms = new List<ModuleElementVM>();
            if (moduleId == 0) return listVms;
            string modulename = _moduleRepository.FindSingle(u => u.Id == moduleId).Name;
           
            foreach (var element in LoadByModuleId(moduleId))
            {
                var accessed = _relevanceRepository.FindSingle(u =>u.Key == accessType 
                    && u.FirstId == firstId && u.SecondId == element.Id);
                ModuleElementVM vm = new ModuleElementVM
                {
                    Id = element.Id,
                    Name = element.Name,
                    ModuleId = element.ModuleId,
                    DomId = element.DomId,
                    ModuleName = modulename,
                    Accessed = accessed != null
                };
                listVms.Add(vm);
            }
            return listVms;
        }

        public void Delete(int id)
        {
            _repository.Delete(u =>u.Id ==id);
        }
    }
}
