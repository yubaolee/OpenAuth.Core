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
// 根据用户账号的不同，采用不同的授权模式，以后可以扩展更多的授权方式
// </summary>
// ***********************************************************************

using System.Collections.Generic;
using Infrastructure;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    /// <summary>
    ///  授权策略上下文，一个典型的策略模式
    /// </summary>
    public class AuthStrategyContext
    {
        private readonly IAuthStrategy _strategy;
        public AuthStrategyContext(IAuthStrategy strategy)
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

        public List<ModuleElement> ModuleElements
        {
            get { return _strategy.ModuleElements; }
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

        public List<KeyDescription> GetProperties(string moduleCode)
        {
            return _strategy.GetProperties(moduleCode);
        }

    }

}
