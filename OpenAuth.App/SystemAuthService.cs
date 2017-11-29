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

using System.Linq;
using OpenAuth.Domain;

namespace OpenAuth.App
{
    /// <summary>
    /// 领域服务
    /// <para>超级管理员权限</para>
    /// </summary>
    public class SystemAuthService : AuthoriseService
    {
        public SystemAuthService()
        {
            _user = new User { Account = "System", Id = string.Empty };
        }

       

        public override IQueryable<Org> GetOrgsQuery()
        {
            return _unitWork.Find<Org>(null);
        }

        public override IQueryable<Resource> GetResourcesQuery()
        {
            return _unitWork.Find<Resource>(null);
        }

        public override IQueryable<ModuleElement> GetModuleElementsQuery()
        {
            return _unitWork.Find<ModuleElement>(null);
        }

        public override IQueryable<Module> GetModulesQuery()
        {
            return _unitWork.Find<Module>(null);
        }

        public override IQueryable<Role> GetRolesQuery()
        {
            //用户角色
            return _unitWork.Find<Role>(null);
        }
    }
}