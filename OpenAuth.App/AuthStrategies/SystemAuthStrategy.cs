// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : 李玉宝
// Created          : 06-06-2018
//
// Last Modified By : 李玉宝
// Last Modified On : 07-05-2018
// ***********************************************************************
// <copyright file="SystemAuthStrategy.cs" company="OpenAuth.App">
//     Copyright (c) http://www.openauth.net.cn. All rights reserved.
// </copyright>
// <summary>
// 超级管理员授权策略
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
    /// 领域服务
    /// <para>超级管理员权限</para>
    /// <para>超级管理员使用guid.empty为ID，可以根据需要修改</para>
    /// </summary>
    public class SystemAuthStrategy : SqlSugarBaseApp<User>, IAuthStrategy
    {
        protected User _user;
        private DbExtension _dbExtension;

        public List<ModuleView> Modules
        {
            get
            {
                return SugarClient.Queryable<ModuleView>().Includes(x=>x.Elements).ToList();
            }
        }

        public List<Role> Roles
        {
            get { return SugarClient.Queryable<Role>().ToList(); }
        }

        public List<ModuleElement> ModuleElements
        {
            get { return SugarClient.Queryable<ModuleElement>().ToList(); }
        }

        public List<Resource> Resources
        {
            get { return SugarClient.Queryable<Resource>().ToList(); }
        }

        public List<OrgView> Orgs
        {
            get { return SugarClient.Queryable<SysOrg>()
                .LeftJoin<User>((org, user) => org.ChairmanId ==user.Id)
                .Select((org,user)=>new OrgView
            {
                Id = org.Id.SelectAll(),
                ChairmanName = user.Name
            }).ToList(); }
        }

        public User User
        {
            get { return _user; }
            set   //禁止外部设置
            {
                throw new Exception("超级管理员，禁止设置用户");
            }  
        }
        

        public List<BuilderTableColumn> GetTableColumns(string moduleCode)
        {
            return SugarClient.Queryable<BuilderTableColumn>().Where(u => u.TableName.ToLower() == moduleCode.ToLower()).ToList();
        }

        public List<BuilderTableColumn> GetTableColumnsFromDb(string moduleCode)
        {
            return _dbExtension.GetTableColumnsFromDb(moduleCode);
        }


        public SystemAuthStrategy(ISqlSugarClient client,DbExtension dbExtension) : base(client, null)
        {
            _dbExtension = dbExtension;
            _user = new User
            {
                Account = Define.SYSTEM_USERNAME,
                Name = "超级管理员",
                Id = Guid.Empty.ToString()
            };
        }
    }
}