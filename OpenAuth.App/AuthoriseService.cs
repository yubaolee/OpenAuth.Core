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
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    /// <summary>
    /// 领域服务
    /// <para>用户授权服务</para>
    /// </summary>
    public class AuthoriseService :BaseApp<User>
    {
        
        protected User _user;

        private List<string> _userRoleIds;    //用户角色GUID

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
                _userRoleIds = UnitWork.Find<Relevance>(u => u.FirstId == _user.Id && u.Key == Define.USERROLE).Select(u => u.SecondId).ToList();
            }
        }

        public void Check(string userName, string password)
        {
            var _user = Repository.FindSingle(u => u.Account == userName);
            if (_user == null)
            {
                throw new Exception("用户帐号不存在");
            }

            if (_user.Password != password)
            {
                throw new Exception("密码错误");
            }
        }

        /// <summary>
        /// 用户可访问的机构
        /// </summary>
        /// <returns>IQueryable&lt;Org&gt;.</returns>
        public virtual IQueryable<Org> GetOrgsQuery()
        {
            var orgids = UnitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == Define.USERORG) ||
                    (u.Key == Define.ROLEORG && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            return UnitWork.Find<Org>(u => orgids.Contains(u.Id));
        }

        /// <summary>
        /// 获取用户可访问的资源
        /// </summary>
        /// <returns>IQueryable&lt;Resource&gt;.</returns>
        public virtual IQueryable<Resource> GetResourcesQuery()
        {
            var resourceIds = UnitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == Define.USERRESOURCE) ||
                    (u.Key == Define.ROLERESOURCE && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            return UnitWork.Find<Resource>(u => resourceIds.Contains(u.Id));
        }

        /// <summary>
        /// 模块菜单权限
        /// </summary>
        public virtual IQueryable<ModuleElement> GetModuleElementsQuery()
        {
            var elementIds = UnitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == Define.USERELEMENT) ||
                    (u.Key == Define.ROLEELEMENT && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            return UnitWork.Find<ModuleElement>(u => elementIds.Contains(u.Id));
        }

        /// <summary>
        /// 得出最终用户拥有的模块
        /// </summary>
        public virtual IQueryable<Module> GetModulesQuery()
        {
            var moduleIds = UnitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == Define.USERMODULE) ||
                    (u.Key == Define.ROLEMODULE && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            return UnitWork.Find<Module>(u => moduleIds.Contains(u.Id)).OrderBy(u => u.SortNo);
        }

        //用户角色
        public virtual IQueryable<Role> GetRolesQuery()
        {
            return UnitWork.Find<Role>(u => _userRoleIds.Contains(u.Id));
        }
    }
}