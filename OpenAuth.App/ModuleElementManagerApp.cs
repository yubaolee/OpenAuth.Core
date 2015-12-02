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
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
{
    public class ModuleElementManagerApp
    {
        private readonly IRepository<ModuleElement> _repository;

        public ModuleElementManagerApp(IRepository<ModuleElement> repository)
        {
            _repository = repository;
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

        public void Delete(int id)
        {
            _repository.Delete(u =>u.Id ==id);
        }
    }
}
