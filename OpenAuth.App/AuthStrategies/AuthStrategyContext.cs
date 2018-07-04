// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : Yubao Li
// Created          : 12-01-2015
//
// Last Modified By : Yubao Li
// Last Modified On : 12-01-2015
// ***********************************************************************
// <copyright file="LoginUserVM.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>
// 授权策略上下文，一个典型的策略模式
// </summary>
// ***********************************************************************

using System.Collections.Generic;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    /// <summary>
    ///  授权策略上下文，一个典型的策略模式
    /// </summary>
    public class AuthStrategyContext
    {
        private readonly NormalAuthStrategy _strategy;
        public AuthStrategyContext(NormalAuthStrategy strategy)
        {
            this._strategy = strategy;
        }

        public User User
        {
            get { return _strategy.User; }
        }

        public List<ModuleView> Modules
        {
            get { return _strategy.Modules; }
        }

        public List<Role> Roles
        {
            get { return _strategy.Roles; }
        }

        public List<Resource> Resources
        {
            get { return _strategy.Resources; }
        }

        public List<Org> Orgs
        {
            get { return _strategy.Orgs; }
        }

    }

}
