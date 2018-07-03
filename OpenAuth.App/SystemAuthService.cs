// ***********************************************************************
// Assembly         : OpenAuth.Domain
// Author           : yubaolee
// Created          : 04-21-2016
//
// Last Modified By : yubaolee
// Last Modified On : 04-21-2016
// Contact : Microsoft
// File: AuthenService.cs
// ***********************************************************************

using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Response;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 领域服务
    /// <para>超级管理员权限</para>
    /// <para>超级管理员使用guid.empty为ID，可以根据需要修改</para>
    /// </summary>
    public class SystemAuthService : AuthoriseService
    {
        public SystemAuthService(IUnitWork unitWork, IRepository<User> repository) : base(unitWork, repository)
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

        public override IQueryable<ModuleElement> GetModuleElementsQuery()
        {
            return UnitWork.Find<ModuleElement>(null);
        }

        public override List<ModuleView> GetModulesQuery()
        {
            var modules = (from module in UnitWork.Find<Module>(null)
                select new ModuleView
                {
                    Name = module.Name,
                    Id = module.Id,
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