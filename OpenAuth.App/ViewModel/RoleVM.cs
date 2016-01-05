// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : yubaolee
// Created          : 11-29-2015
//
// Last Modified By : yubaolee
// Last Modified On : 11-29-2015
// ***********************************************************************
// <copyright file="RoleVM.cs" company="www.cnblogs.com/yubaolee">
//     Copyright (c) www.cnblogs.com/yubaolee. All rights reserved.
// </copyright>
// <summary>角色模型视图</summary>
// ***********************************************************************

using System;
using Infrastructure;
using OpenAuth.Domain;

namespace OpenAuth.App.ViewModel
{
    public partial class RoleVM
    {
        /// <summary>
        /// 用户ID
        /// </summary>
        /// <returns></returns>
        public int Id { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        /// <returns></returns>
        public string Name { get; set; }


        /// <summary>
        /// 所属部门节点语义ID
        /// </summary>
        /// <returns></returns>
        public string OrgCascadeId { get; set; }

        /// <summary>
        /// 所属部门名称
        /// </summary>
        /// <returns></returns>
        public string OrgName { get; set; }

        /// <summary>
        ///是否属于某用户 
        /// </summary>
        public bool IsBelongUser { get; set; }

        public static implicit operator RoleVM(Role role)
        {
            return role.MapTo<RoleVM>();
        }

        public static implicit operator Role(RoleVM rolevm)
        {
            return rolevm.MapTo<Role>();
        }

    }
}
