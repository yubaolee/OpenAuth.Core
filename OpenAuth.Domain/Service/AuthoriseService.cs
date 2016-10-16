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

using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.Domain.Service
{
    /// <summary>
    /// 领域服务
    /// <para>用户授权服务</para>
    /// </summary>
    public class AuthoriseService
    {
        protected IUnitWork _unitWork;
        protected User _user;

        private List<Guid> _userRoleIds;    //用户角色GUID

        public AuthoriseService(IUnitWork unitWork)
        {
            _unitWork = unitWork;
        }

        public List<Module> Modules
        {
            get { return GetModulesQuery().ToList(); }
        }

        public List<Role> Roles
        {
            get { return GetRolesQuery().ToList(); }
        }

        public List<ModuleElement> ModuleElements
        {
            get { return GetModuleElementsQuery().ToList(); }
        }

        public List<Resource> Resources
        {
            get { return GetResourcesQuery().ToList(); }
        }

        public List<Org> Orgs
        {
            get { return GetOrgsQuery().ToList(); }
        }

        public User User
        {
            get { return _user; }
            set
            {
                _user = value;
                _userRoleIds = _unitWork.Find<Relevance>(u => u.FirstId == _user.Id && u.Key == "UserRole").Select(u => u.SecondId).ToList();
            }
        }

        public void Check(string userName, string password)
        {
            var _user = _unitWork.FindSingle<User>(u => u.Account == userName);
            if (_user == null)
            {
                throw new Exception("用户帐号不存在");
            }
            _user.CheckPassword(password);
        }

        /// <summary>
        /// 用户可访问的机构
        /// </summary>
        /// <returns>IQueryable&lt;Org&gt;.</returns>
        public virtual IQueryable<Org> GetOrgsQuery()
        {
            var orgids = _unitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == "UserOrg") ||
                    (u.Key == "RoleOrg" && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            return _unitWork.Find<Org>(u => orgids.Contains(u.Id));
        }

        /// <summary>
        /// 获取用户可访问的资源
        /// </summary>
        /// <returns>IQueryable&lt;Resource&gt;.</returns>
        public virtual IQueryable<Resource> GetResourcesQuery()
        {
            var resourceIds = _unitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == "UserResource") ||
                    (u.Key == "RoleResource" && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            return _unitWork.Find<Resource>(u => resourceIds.Contains(u.Id));
        }

        /// <summary>
        /// 模块菜单权限
        /// </summary>
        public virtual IQueryable<ModuleElement> GetModuleElementsQuery()
        {
            var elementIds = _unitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == "UserElement") ||
                    (u.Key == "RoleElement" && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            return _unitWork.Find<ModuleElement>(u => elementIds.Contains(u.Id));
        }

        /// <summary>
        /// 得出最终用户拥有的模块
        /// </summary>
        public virtual IQueryable<Module> GetModulesQuery()
        {
            var moduleIds = _unitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == "UserModule") ||
                    (u.Key == "RoleModule" && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            return _unitWork.Find<Module>(u => moduleIds.Contains(u.Id)).OrderBy(u => u.SortNo);
        }

        //用户角色
        public virtual IQueryable<Role> GetRolesQuery()
        {
            return _unitWork.Find<Role>(u => _userRoleIds.Contains(u.Id));
        }
    }
}