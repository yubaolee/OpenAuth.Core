// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : 李玉宝
// Created          : 07-05-2018
//
// Last Modified By : 李玉宝
// Last Modified On : 07-05-2018
// ***********************************************************************
// <copyright file="IAuthStrategy.cs" company="OpenAuth.App">
//     Copyright (c) http://www.openauth.net.cn. All rights reserved.
// </copyright>
// <summary>
// 授权策略接口
// </summary>
// ***********************************************************************


using System;
using System.Collections.Generic;
using Infrastructure;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    public interface IAuthStrategy 
    {
         List<ModuleView> Modules { get; }

        List<ModuleElement> ModuleElements { get; }

        List<Role> Roles { get; }

         List<Resource> Resources { get; }

         List<OrgView> Orgs { get; }

         User User
        {
            get;set;
        }
         
        /// <summary>
        /// 获取角色可以访问的字段信息
        /// </summary>
        /// <param name="moduleCode"></param>
        /// <returns></returns>
        List<BuilderTableColumn> GetTableColumns(string moduleCode);
        /// <summary>
        /// 获取角色可访问的字段信息，因为MVC版本没有代码生成器，所以只能通过直接读取数据库表结构的方式
        /// </summary>
        /// <param name="moduleCode"></param>
        /// <returns></returns>
        [Obsolete("获取角色可访问的字段信息，因为MVC版本没有代码生成器，所以只能通过直接读取数据库表结构的方式")]
        List<BuilderTableColumn> GetTableColumnsFromDb(string moduleCode);

    }
}