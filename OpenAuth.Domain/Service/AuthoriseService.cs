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
        private IUserRepository _repository;
        private IModuleRepository _moduleRepository;
        private IRelevanceRepository _relevanceRepository;
        private IRepository<ModuleElement> _moduleElementRepository;
        private IResourceRepository _resourceRepository;
        private IOrgRepository _orgRepository;

        private User _user;
        private List<Module> _modules;   //用户可访问的模块
        private List<ModuleElement> _moduleElements; //用户可访问的菜单
        private List<Resource> _resources;  //用户可访问的资源
        private List<Org> _orgs;    //用户可访问的机构

        public AuthoriseService(IUserRepository repository,
            IModuleRepository moduleRepository,
            IRelevanceRepository relevanceRepository,
            IRepository<ModuleElement> moduleElementRepository,
            IResourceRepository resourceRepository,
            IOrgRepository orgRepository)
        {
            _repository = repository;
            _moduleRepository = moduleRepository;
            _relevanceRepository = relevanceRepository;
            _moduleElementRepository = moduleElementRepository;
            _resourceRepository = resourceRepository;
            _orgRepository = orgRepository;
        }

        public List<Module> Modules
        {
            get { return _modules; }
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
            var _user = _repository.FindSingle(u => u.Account == userName);
            if (_user == null)
            {
                throw new Exception("用户帐号不存在");
            }
            _user.CheckPassword(password);
        }

        /// <summary>
        /// 设置开发者账号
        /// </summary>
        public void SetSysUser()
        {
            _user = new User
            {
                Account = "System"
            };
        }

        public void GetUserAccessed(string name)
        {
            if (name == "System")
            {
                _modules = _moduleRepository.Find(null).ToList();
                _moduleElements = _moduleElementRepository.Find(null).ToList();

                _resources = _resourceRepository.Find(null).OrderBy(u => u.SortNo).ToList();

                _orgs = _orgRepository.Find(null).OrderBy(u => u.SortNo).ToList();
            }
            else
            {
                _user = _repository.FindSingle(u => u.Account == name);
                //用户角色
                var userRoleIds = _relevanceRepository.Find(u => u.FirstId == _user.Id && u.Key == "UserRole").Select(u => u.SecondId).ToList();

                //用户角色与自己分配到的模块ID
                var moduleIds = _relevanceRepository.Find(
                        u =>
                            (u.FirstId == _user.Id && u.Key == "UserModule") ||
                            (u.Key == "RoleModule" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();
                //用户角色与自己分配到的菜单ID
                var elementIds = _relevanceRepository.Find(
                       u =>
                           (u.FirstId == _user.Id && u.Key == "UserElement") ||
                           (u.Key == "RoleElement" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();
                //得出最终用户拥有的模块
                _modules = _moduleRepository.Find(u => moduleIds.Contains(u.Id)).OrderBy(u => u.SortNo).ToList();

                //模块菜单权限
                _moduleElements = _moduleElementRepository.Find(u => elementIds.Contains(u.Id)).ToList();

                //用户角色与自己分配到的资源ID
                var resourceIds = _relevanceRepository.Find(
                        u =>
                            (u.FirstId == _user.Id && u.Key == "UserResource") ||
                            (u.Key == "RoleResource" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();
                _resources = _resourceRepository.Find(u => resourceIds.Contains(u.Id)).ToList();

                //用户角色与自己分配到的机构ID
                var orgids = _relevanceRepository.Find(
                        u =>
                            (u.FirstId == _user.Id && u.Key == "UserAccessedOrg") ||
                            (u.Key == "RoleAccessedOrg" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();
                _orgs = _orgRepository.Find(u => orgids.Contains(u.Id)).ToList();
            }
        }
    }
}