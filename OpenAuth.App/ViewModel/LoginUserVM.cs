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
// <summary>登陆视图模型</summary>
// ***********************************************************************

using System.Collections.Generic;
using OpenAuth.Domain;

namespace OpenAuth.App.ViewModel
{
    /// <summary>
    /// 登陆用户视图模型
    /// </summary>
    public class LoginUserVM 
    {
        public User User { get; set; }
        /// <summary>
        /// 用户可以访问到的模块（包括所属角色与自己的所有模块）
        /// </summary>
        public List<ModuleView> Modules { get; set; }

        //用户可以访问的资源
        public List<Resource> Resources { get; set; }

        /// <summary>
        ///  用户所属机构
        /// </summary>
        public List<Org> Orgs { get; set; }  
    }

}
