using System;
using System.Collections.Generic;
using OpenAuth.App.Interface;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class RoleApp : BaseApp<Role>
    {
        private RevelanceManagerApp _revelanceApp;

        private IAuth _auth;

        /// <summary>
        /// 加载当前登录用户可访问的全部角色
        /// </summary>
        public List<Role> Load()
        {
            var loginUser = _auth.GetCurrentUser();
            return loginUser.Roles;
        }


        public void Add(RoleView obj)
        {
          
            Role role = obj;
            role.CreateTime = DateTime.Now;
            Repository.Add(role);
            obj.Id = role.Id;   //要把保存后的ID存入view

        }
        
        public void Update(RoleView obj)
        {
            Role role = obj;

            UnitWork.Update<Role>(u => u.Id == obj.Id, u => new Role
            {
                Name = role.Name,
                Status = role.Status
            });

        }


        public RoleApp(IUnitWork unitWork, IRepository<Role> repository,
            RevelanceManagerApp app,IAuth auth, DataPrivilegeRuleApp dataPrivilegeRuleApp) : base(unitWork, repository, auth, dataPrivilegeRuleApp)
        {
            _revelanceApp = app;
            _auth = auth;
        }
    }
}