// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : 李玉宝
// Created          : 06-06-2018
//
// Last Modified By : 李玉宝
// Last Modified On : 07-05-2018
// ***********************************************************************
// <copyright file="SystemAuthStrategy.cs" company="OpenAuth.App">
//     Copyright (c) http://www.openauth.me. All rights reserved.
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
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 领域服务
    /// <para>超级管理员权限</para>
    /// <para>超级管理员使用guid.empty为ID，可以根据需要修改</para>
    /// </summary>
    public class SystemAuthStrategy : BaseApp<User>, IAuthStrategy
    {
        protected User _user;
        private DbExtension _dbExtension;

        public List<ModuleView> Modules
        {
            get {
                var modules = (from module in UnitWork.Find<Module>(null)
                    select new ModuleView
                    {
                        SortNo = module.SortNo,
                        Name = module.Name,
                        Id = module.Id,
                        CascadeId = module.CascadeId,
                        Code = module.Code,
                        IconName = module.IconName,
                        Url = module.Url,
                        ParentId = module.ParentId,
                        ParentName = module.ParentName,
                        IsSys = module.IsSys,
                        Status = module.Status
                    }).ToList();

                foreach (var module in modules)
                {
                    module.Elements = UnitWork.Find<ModuleElement>(u => u.ModuleId == module.Id).ToList();
                }

                return modules;
            }
        }

        public List<Role> Roles
        {
            get { return UnitWork.Find<Role>(null).ToList(); }
        }

        public List<ModuleElement> ModuleElements
        {
            get { return UnitWork.Find<ModuleElement>(null).ToList(); }
        }

        public List<Resource> Resources
        {
            get { return UnitWork.Find<Resource>(null).ToList(); }
        }

        public List<Org> Orgs
        {
            get { return UnitWork.Find<Org>(null).ToList(); }
        }

        public User User
        {
            get { return _user; }
            set   //禁止外部设置
            {
                throw new Exception("超级管理员，禁止设置用户");
            }  
        }

        public List<KeyDescription> GetProperties(string moduleCode)
        {
//            var module = UnitWork.FindSingle<Module>(u =>u.Code == moduleCode);
//            if(module == null)
//            {
//                throw new Exception("该模块不存在");
//            }
//            if(module.IsSys){
//                throw new Exception("系统内置模块，不能进行字段分配");
//            }
            return _dbExtension.GetProperties(moduleCode);
        }


        public SystemAuthStrategy(IUnitWork unitWork, IRepository<User> repository, DbExtension dbExtension) : base(unitWork, repository, null)
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