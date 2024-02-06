﻿// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : 李玉宝
// Created          : 06-06-2018
//
// Last Modified By : 李玉宝
// Last Modified On : 07-04-2018
// ***********************************************************************
// <copyright file="NormalAuthStrategy.cs" company="OpenAuth.App">
//     Copyright (c) http://www.openauth.net.cn. All rights reserved.
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
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 普通用户授权策略
    /// </summary>
    public class NormalAuthStrategy :BaseStringApp<User,OpenAuthDBContext>, IAuthStrategy
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
                        SortNo = module.SortNo,
                        Name = module.Name,
                        Code = module.Code,
                        CascadeId = module.CascadeId,
                        Id = module.Id,
                        IconName = module.IconName,
                        Url = module.Url,
                        ParentId = module.ParentId,
                        ParentName = module.ParentName,
                        IsSys = module.IsSys,
                        Status = module.Status
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

        public List<SysOrg> Orgs
        {
            get
            {
                var orgids = UnitWork.Find<Relevance>(
                    u =>u.FirstId == _user.Id && u.Key == Define.USERORG).Select(u => u.SecondId);
                return UnitWork.Find<SysOrg>(u => orgids.Contains(u.Id)).ToList();
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
        

        public List<BuilderTableColumn> GetTableColumns(string moduleCode)
        {
            var allprops = UnitWork.Find<BuilderTableColumn>(u => u.TableName.ToLower() == moduleCode.ToLower());
            //如果是子表，直接返回所有字段
            var builderTable = UnitWork.FirstOrDefault<BuilderTable>(u => u.TableName.ToLower() == moduleCode.ToLower());
            if (builderTable == null)
            {
                throw new Exception($"代码生成器中找不到{moduleCode.ToLower()}的定义");
            }
            //如果是子表，因为不能在模块界面分配，所以直接返回所有字段，后期可以优化。
            if (builderTable.ParentTableId != null)
            {
                return allprops.ToList();
            }

            //如果是系统模块，直接返回所有字段。防止开发者把模块配置成系统模块，还在外层调用loginContext.GetProperties("xxxx");
            bool? isSysModule = UnitWork.FirstOrDefault<Module>(u => u.Code == moduleCode)?.IsSys;
            if (isSysModule!= null && isSysModule.Value)
            {
                return allprops.ToList();
            }
            
            var props =UnitWork.Find<Relevance>(u =>
                    u.Key == Define.ROLEDATAPROPERTY && _userRoleIds.Contains(u.FirstId) && u.SecondId == moduleCode)
                .Select(u => u.ThirdId);

            return allprops.Where(u => props.Contains(u.ColumnName)).ToList();
        }

        public List<BuilderTableColumn> GetTableColumnsFromDb(string moduleCode)
        {
            var allprops = _dbExtension.GetTableColumnsFromDb(moduleCode);

            //如果是系统模块，直接返回所有字段。防止开发者把模块配置成系统模块，还在外层调用loginContext.GetProperties("xxxx");
            bool? isSysModule = UnitWork.FirstOrDefault<Module>(u => u.Code == moduleCode)?.IsSys;
            if (isSysModule!= null && isSysModule.Value)
            {
                return allprops.ToList();
            }
            
            var props =UnitWork.Find<Relevance>(u =>
                    u.Key == Define.ROLEDATAPROPERTY && _userRoleIds.Contains(u.FirstId) && u.SecondId == moduleCode)
                .Select(u => u.ThirdId);

            return allprops.Where(u => props.Contains(u.ColumnName)).ToList();
        }

        //用户角色

        public NormalAuthStrategy(IUnitWork<OpenAuthDBContext> unitWork, IRepository<User,OpenAuthDBContext> repository, DbExtension dbExtension) : base(unitWork, repository,null)
        {
            _dbExtension = dbExtension;
        }
    }
}