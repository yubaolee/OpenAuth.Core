// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : 李玉宝
// Created          : 06-06-2018
//
// Last Modified By : 李玉宝
// Last Modified On : 07-05-2018
// ***********************************************************************
// <copyright file="SystemAuthStrategy.cs" company="OpenAuth.App">
//     Copyright (c) http://www.openauth.me. All rights reserved.
// </copyright>
// <summary>
// 超级管理员授权策略
// </summary>
// ***********************************************************************

using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 领域服务
    /// <para>超级管理员权限</para>
    /// <para>超级管理员使用guid.empty为ID，可以根据需要修改</para>
    /// </summary>
    public class SystemAuthStrategy : NormalAuthStrategy
    {
        public SystemAuthStrategy(IUnitWork unitWork, IRepository<User> repository) : base(unitWork, repository)
        {
            _user = new User
            {
                Account = "System",
                Name = "超级管理员",
                Id = Guid.Empty.ToString()
            };
        }
      

        public override IQueryable<Org> GetOrgsQuery()
        {
            return UnitWork.Find<Org>(null);
        }

        public override IQueryable<Resource> GetResourcesQuery()
        {
            return UnitWork.Find<Resource>(null);
        }

        public override List<ModuleView> GetModulesQuery()
        {
            var modules = (from module in UnitWork.Find<Module>(null)
                select new ModuleView
                {
                    Name = module.Name,
                    Id = module.Id,
                    CascadeId = module.CascadeId,
                    Code = module.Code,
                    IconName = module.IconName,
                    Url = module.Url,
                    ParentId = module.ParentId,
                    ParentName = module.ParentName
                }).ToList();

            foreach (var module in modules)
            {
                module.Elements = UnitWork.Find<ModuleElement>(u => u.ModuleId == module.Id).ToList();
            }

            return modules;
        }

        public override IQueryable<Role> GetRolesQuery()
        {
            //用户角色
            return UnitWork.Find<Role>(null);
        }

      
    }
}