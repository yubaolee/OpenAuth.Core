// ***********************************************************************
// Assembly         : OpenAuth.Repository
// Author           : yubaolee
// Created          : 11-26-2015
//
// Last Modified By : yubaolee
// Last Modified On : 11-26-2015
// ***********************************************************************
// <copyright file="UserModuleRepository.cs" company="www.cnblogs.com/yubaolee">
//     Copyright (c) www.cnblogs.com/yubaolee. All rights reserved.
// </copyright>
// <summary>用户菜单分配操作</summary>
// ***********************************************************************


using System;
using System.Linq;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Repository
{
    public class UserModuleRepository : BaseRepository<UserModule>, IUserModuleRepository
    {
        /// <summary>
        /// 删除指定用户关联的模块
        /// </summary>
        /// <param name="userIds">The user ids.</param>
        public void DeleteByUser(params int[] userIds)
        {
            Delete(u =>userIds.Contains(u.UserId));
        }

        /// <summary>
        /// 为指定的用户分配模块
        /// </summary>
        public void AddUserModule(int userId, params int[] moduleIds)
        {
            foreach (var moduleId in moduleIds)
            {
                Add(new UserModule
                {
                    UserId = userId,
                    ModuleId = moduleId,
                    OperateTime = DateTime.Now
                });
            }
            Save();
        }
    }
}
