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
        private IUnitWork _unitWork;

        private User _user;
        private List<Module> _modules;   //用户可访问的模块
        private List<ModuleElement> _moduleElements; //用户可访问的菜单
        private List<Resource> _resources;  //用户可访问的资源
        private List<Org> _orgs;    //用户可访问的机构
        private List<Role> _roles;   //用户角色

        public AuthoriseService(IUnitWork unitWork)
        {
            _unitWork = unitWork;
        }

        public List<Module> Modules
        {
            get { return _modules; }
        }

        public List<Role> Roles
        {
            get { return _roles;}
        }

        public List<ModuleElement> ModuleElements
        {
            get { return _moduleElements; }
        }

        public List<Resource> Resources
        {
            get { return _resources; }
        }

        public List<Org> Orgs
        {
            get { return _orgs; }
        }

        public User User
        {
            get { return _user; }
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
        /// 加载用户可访问的所有机构/资源/菜单
        /// <para>李玉宝于2016-07-19 10:32:19</para>
        /// </summary>
        /// <param name="name">The name.</param>
        public void LoadAuthControls(string name)
        {
            if (name == "System")
            {
                _user = new User{Account = "System", Id = Guid.Empty};
                LoadForSystem();
            }
            else
            {
                _user = _unitWork.FindSingle<User>(u => u.Account == name);
                if (_user != null)
                {
                    LoadForUser();
                }
            }
        }

        /// <summary>
        /// 加载用户权限
        /// <para>李玉宝于2016-07-19 10:20:16</para>
        /// </summary>
        /// <param name="name">The name.</param>
        private void LoadForUser()
        {
            //用户角色
            var userRoleIds =
                _unitWork.Find<Relevance>(u => u.FirstId == _user.Id && u.Key == "UserRole").Select(u => u.SecondId).ToList();

            _roles = _unitWork.Find<Role>(u => userRoleIds.Contains(u.Id)).ToList();
            //用户角色与自己分配到的模块ID
            var moduleIds = _unitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == "UserModule") ||
                    (u.Key == "RoleModule" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            //得出最终用户拥有的模块
            _modules = _unitWork.Find<Module>(u => moduleIds.Contains(u.Id)).OrderBy(u => u.SortNo).ToList();

            //用户角色与自己分配到的菜单ID
            var elementIds = _unitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == "UserElement") ||
                    (u.Key == "RoleElement" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            //模块菜单权限
            _moduleElements = _unitWork.Find<ModuleElement>(u => elementIds.Contains(u.Id)).ToList();

            //用户角色与自己分配到的资源ID
            var resourceIds = _unitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == "UserResource") ||
                    (u.Key == "RoleResource" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            _resources = _unitWork.Find<Resource>(u => resourceIds.Contains(u.Id)).ToList();

            //用户角色与自己分配到的机构ID
            var orgids = _unitWork.Find<Relevance>(
                u =>
                    (u.FirstId == _user.Id && u.Key == "UserOrg") ||
                    (u.Key == "RoleOrg" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
            _orgs = _unitWork.Find<Org>(u => orgids.Contains(u.Id)).ToList();
        }

        /// <summary>
        /// 加载系统管理员权限
        /// <para>李玉宝于2016-07-19 10:19:31</para>
        /// </summary>
        private void LoadForSystem()
        {
            _modules = _unitWork.Find<Module>(null).ToList();
            _moduleElements = _unitWork.Find<ModuleElement>(null).ToList();
            _roles = _unitWork.Find<Role>(null).ToList();
            _resources = _unitWork.Find<Resource>(null).OrderBy(u => u.SortNo).ToList();
            _orgs = _unitWork.Find<Org>(null).OrderBy(u => u.SortNo).ToList();
        }
    }
}