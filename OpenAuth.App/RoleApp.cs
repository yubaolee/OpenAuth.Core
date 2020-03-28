using System;
using System.Collections.Generic;
using OpenAuth.App.Interface;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;
using System.Linq;
using OpenAuth.App.Request;

namespace OpenAuth.App
{
    public class RoleApp : BaseApp<Role>
    {
        private RevelanceManagerApp _revelanceApp;

        /// <summary>
        /// 加载当前登录用户可访问的全部角色
        /// </summary>
        public List<Role> Load(QueryRoleListReq request)
        {
            var loginUser = _auth.GetCurrentUser();
            var roles = loginUser.Roles;
            if (!string.IsNullOrEmpty(request.key))
            {
                roles = roles.Where(u => u.Name.Contains(request.key)).ToList();
            }

            return roles;
        }


        public void Add(RoleView obj)
        {
          
            Role role = obj;
            role.CreateTime = DateTime.Now;
            Repository.Add(role);
            obj.Id = role.Id;   //要把保存后的ID存入view
           
            //如果当前账号不是SYSTEM，则直接分配
            var loginUser = _auth.GetCurrentUser();
            if (loginUser.User.Account != Define.SYSTEM_USERNAME)
            {
                _revelanceApp.Assign(new AssignReq
                {
                    type = Define.USERROLE,
                    firstId = loginUser.User.Id,
                    secIds = new[] {role.Id}
                });
            }
            

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
            RevelanceManagerApp app,IAuth auth) : base(unitWork, repository, auth)
        {
            _revelanceApp = app;
        }
    }
}