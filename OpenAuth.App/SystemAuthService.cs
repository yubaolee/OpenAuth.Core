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
using System.Linq;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    /// <summary>
    /// 领域服务
    /// <para>超级管理员权限</para>
    /// <para>todo:超级管理员使用guid.empty为ID，可以根据需要修改</para>
    /// </summary>
    public class SystemAuthService : AuthoriseService
    {
        public SystemAuthService()
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

        public override IQueryable<Module> GetModulesQuery()
        {
            return UnitWork.Find<Module>(null);
        }

        public override IQueryable<Role> GetRolesQuery()
        {
            //用户角色
            return UnitWork.Find<Role>(null);
        }
    }
}