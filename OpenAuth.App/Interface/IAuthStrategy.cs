// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : 李玉宝
// Created          : 07-05-2018
//
// Last Modified By : 李玉宝
// Last Modified On : 07-05-2018
// ***********************************************************************
// <copyright file="IAuthStrategy.cs" company="OpenAuth.App">
//     Copyright (c) http://www.openauth.me. All rights reserved.
// </copyright>
// <summary>
// 授权策略接口
// </summary>
// ***********************************************************************


using System.Collections.Generic;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    public interface IAuthStrategy 
    {
         List<ModuleView> Modules { get; }

         List<Role> Roles { get; }

         List<Resource> Resources { get; }

         List<Org> Orgs { get; }

         User User
        {
            get;set;
        }

    }
}