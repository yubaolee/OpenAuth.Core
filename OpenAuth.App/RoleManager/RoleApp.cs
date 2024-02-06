using System;
using System.Collections.Generic;
using OpenAuth.App.Interface;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;
using System.Linq;
using System.Threading.Tasks;
using Infrastructure;
using Microsoft.EntityFrameworkCore;
using OpenAuth.App.Request;
using OpenAuth.Repository;

namespace OpenAuth.App
{
    public class RoleApp : BaseStringApp<Role,OpenAuthDBContext>
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
        
        /// <summary>
        /// 获取所有的角色
        /// 为了控制权限，通常只用于流程实例选择执行角色，其他地方请使用Load
        /// </summary>
        public async Task<TableResp<Role>> LoadAll(QueryRoleListReq request)
        {
            var result = new TableResp<Role>();
            var objs = UnitWork.Find<Role>(null);
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.Name.Contains(request.key));
            }

            result.data = await objs.OrderBy(u => u.Name)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).ToListAsync();
            result.count = await objs.CountAsync();
            return result;
        }


        /// <summary>
        /// 添加角色，如果当前登录用户不是System，则直接把新角色分配给当前登录用户
        /// </summary>
        public void Add(RoleView obj)
        {
           UnitWork.ExecuteWithTransaction(() =>
           {
               Role role = obj;
               role.CreateTime = DateTime.Now;
               UnitWork.Add(role);
               UnitWork.Save();
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
           });
        }
        
        /// <summary>
        /// 删除角色时，需要删除角色对应的权限
        /// </summary>
        /// <param name="ids"></param>
        public override void Delete(string[] ids)
        {
            UnitWork.ExecuteWithTransaction(() =>
            {
                UnitWork.Delete<Relevance>(u=>(u.Key == Define.ROLEMODULE || u.Key == Define.ROLEELEMENT) && ids.Contains(u.FirstId));
                UnitWork.Delete<Relevance>(u=>u.Key == Define.USERROLE && ids.Contains(u.SecondId));
                UnitWork.Delete<Role>(u =>ids.Contains(u.Id));
                UnitWork.Save();
            });
        }
        
        /// <summary>
        /// 更新角色属性
        /// </summary>
        /// <param name="obj"></param>
        public void Update(RoleView obj)
        {
            Role role = obj;

            UnitWork.Update<Role>(u => u.Id == obj.Id, u => new Role
            {
                Name = role.Name,
                Status = role.Status
            });

        }


        public RoleApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<Role,OpenAuthDBContext> repository,
            RevelanceManagerApp app,IAuth auth) : base(unitWork, repository, auth)
        {
            _revelanceApp = app;
        }

        
    }
}