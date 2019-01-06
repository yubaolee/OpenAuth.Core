// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : 李玉宝
// Created          : 06-06-2018
//
// Last Modified By : 李玉宝
// Last Modified On : 07-04-2018
// ***********************************************************************
// <copyright file="NormalAuthStrategy.cs" company="OpenAuth.App">
//     Copyright (c) http://www.openauth.me. All rights reserved.
// </copyright>
// <summary>
// 普通用户授权策略
// </summary>
// ***********************************************************************


using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 普通用户授权策略
    /// </summary>
    public class NormalAuthStrategy :BaseApp<User>, IAuthStrategy
    {
        
        protected User _user;

        private List<string> _userRoleIds;    //用户角色GUID
        private DbExtension _dbExtension;

        public List<ModuleView> Modules
        {
            get {
                var moduleIds = UnitWork.Find<Relevance>(
                    u =>
                        (u.Key == Define.ROLEMODULE && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);

                var modules = (from module in UnitWork.Find<Module>(u =>moduleIds.Contains(u.Id))
                    select new ModuleView
                    {
                        Name = module.Name,
                        Code = module.Code,
                        CascadeId = module.CascadeId,
                        Id = module.Id,
                        IconName = module.IconName,
                        Url = module.Url,
                        ParentId = module.ParentId,
                        ParentName = module.ParentName,
                        IsSys = module.IsSys
                    }).ToList();

                var usermoduleelements = ModuleElements;

                foreach (var module in modules)
                {
                    module.Elements =usermoduleelements.Where(u => u.ModuleId == module.Id).ToList();
                }

                return modules;
            }
        }

        public List<ModuleElement> ModuleElements
        {
            get
            {
                var elementIds = UnitWork.Find<Relevance>(
                    u =>
                        (u.Key == Define.ROLEELEMENT && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
                var usermoduleelements = UnitWork.Find<ModuleElement>(u => elementIds.Contains(u.Id));
                return usermoduleelements.ToList();
            }
        }

        public List<Role> Roles
        {
            get { return UnitWork.Find<Role>(u => _userRoleIds.Contains(u.Id)).ToList(); }
        }

        public List<Resource> Resources
        {
            get
            {
                var resourceIds = UnitWork.Find<Relevance>(
                    u =>
                        (u.Key == Define.ROLERESOURCE && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
                return UnitWork.Find<Resource>(u => resourceIds.Contains(u.Id)).ToList();
            }
        }

        public List<Org> Orgs
        {
            get
            {
                var orgids = UnitWork.Find<Relevance>(
                    u =>
                        (u.FirstId == _user.Id && u.Key == Define.USERORG) ||
                        (u.Key == Define.ROLEORG && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId);
                return UnitWork.Find<Org>(u => orgids.Contains(u.Id)).ToList();
            }
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

        /// <summary>
        /// 获取用户可访问的字段列表
        /// </summary>
        /// <param name="moduleCode">模块的code</param>
        /// <returns></returns>
        public List<KeyDescription> GetProperties(string moduleCode)
        {
            var allprops = _dbExtension.GetProperties(moduleCode);
            var props =UnitWork.Find<Relevance>(u =>
                    u.Key == Define.ROLEDATAPROPERTY && _userRoleIds.Contains(u.FirstId) && u.SecondId == moduleCode)
                .Select(u => u.ThirdId);

            return allprops.Where(u => props.Contains(u.Key)).ToList();
        }

        //用户角色

        public NormalAuthStrategy(IUnitWork unitWork, IRepository<User> repository, DbExtension dbExtension) : base(unitWork, repository)
        {
            _dbExtension = dbExtension;
        }
    }
}