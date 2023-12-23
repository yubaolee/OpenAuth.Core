// ***********************************************************************
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
using SqlSugar;

namespace OpenAuth.App
{
    /// <summary>
    /// 普通用户授权策略
    /// </summary>
    public class NormalAuthStrategy : SqlSugarBaseApp<User>, IAuthStrategy
    {
        
        protected User _user;

        private List<string> _userRoleIds;    //用户角色GUID
        private DbExtension _dbExtension;

        public List<ModuleView> Modules
        {
            get {
                var moduleIds = SugarClient.Queryable<Relevance>().Where(
                    u =>
                        (u.Key == Define.ROLEMODULE && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();
                
                return SugarClient.Queryable<ModuleView>().Where(m =>moduleIds.Contains(m.Id)).Includes(x=>x.Elements).ToList();
                
            }
        }

        public List<ModuleElement> ModuleElements
        {
            get
            {
                var elementIds = SugarClient.Queryable<Relevance>().Where(
                    u =>
                        (u.Key == Define.ROLEELEMENT && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();
                var usermoduleelements = SugarClient.Queryable<ModuleElement>().Where(u => elementIds.Contains(u.Id));
                return usermoduleelements.ToList();
            }
        }

        public List<Role> Roles
        {
            get { return SugarClient.Queryable<Role>().Where(u => _userRoleIds.Contains(u.Id)).ToList(); }
        }

        public List<Resource> Resources
        {
            get
            {
                var resourceIds = SugarClient.Queryable<Relevance>().Where(
                    u =>
                        (u.Key == Define.ROLERESOURCE && _userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();
                return SugarClient.Queryable<Resource>().Where(u => resourceIds.Contains(u.Id)).ToList();
            }
        }

        public List<OrgView> Orgs
        {
            get
            {
                var orgids = SugarClient.Queryable<Relevance>().Where(
                    u =>u.FirstId == _user.Id && u.Key == Define.USERORG).Select(u => u.SecondId).ToList();
                return SugarClient.Queryable<SysOrg>().Where(org =>orgids.Contains(org.Id))
                    .LeftJoin<User>((org, user) => org.ChairmanId ==user.Id)
                    .Select((org,user)=>new OrgView
                    {
                        Id = org.Id.SelectAll(),
                        ChairmanName = user.Name
                    }).ToList();
            }
        }

        public User User
        {
            get { return _user; }
            set
            {
                _user = value;
                _userRoleIds = SugarClient.Queryable<Relevance>().Where(u => u.FirstId == _user.Id && u.Key == Define.USERROLE)
                    .Select(u => u.SecondId).ToList();
            }
        }
        

        public List<BuilderTableColumn> GetTableColumns(string moduleCode)
        {
            var allprops = SugarClient.Queryable<BuilderTableColumn>()
                .Where(u => u.TableName.ToLower() == moduleCode.ToLower());
            //如果是子表，直接返回所有字段
            var builderTable = SugarClient.Queryable<BuilderTable>().First(u => u.TableName.ToLower() == moduleCode.ToLower());
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
            bool? isSysModule = SugarClient.Queryable<Module>().First(u => u.Code == moduleCode)?.IsSys;
            if (isSysModule!= null && isSysModule.Value)
            {
                return allprops.ToList();
            }
            
            var props =SugarClient.Queryable<Relevance>().Where(u =>
                    u.Key == Define.ROLEDATAPROPERTY && _userRoleIds.Contains(u.FirstId) && u.SecondId == moduleCode)
                .Select(u => u.ThirdId).ToList();

            return allprops.Where(u => props.Contains(u.ColumnName)).ToList();
        }

        public List<BuilderTableColumn> GetTableColumnsFromDb(string moduleCode)
        {
            var allprops = _dbExtension.GetTableColumnsFromDb(moduleCode);

            //如果是系统模块，直接返回所有字段。防止开发者把模块配置成系统模块，还在外层调用loginContext.GetProperties("xxxx");
            bool? isSysModule = SugarClient.Queryable<Module>().First(u => u.Code == moduleCode)?.IsSys;
            if (isSysModule!= null && isSysModule.Value)
            {
                return allprops.ToList();
            }
            
            var props =SugarClient.Queryable<Relevance>().Where(u =>
                    u.Key == Define.ROLEDATAPROPERTY && _userRoleIds.Contains(u.FirstId) && u.SecondId == moduleCode)
                .Select(u => u.ThirdId).ToList();

            return allprops.Where(u => props.Contains(u.ColumnName)).ToList();
        }

        //用户角色

        public NormalAuthStrategy(ISqlSugarClient client,DbExtension dbExtension) : base(client, null)
        {
            _dbExtension = dbExtension;
        }
    }
}