﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Castle.Core.Internal;
using Infrastructure;
using Infrastructure.Extensions;
using Microsoft.EntityFrameworkCore;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;
namespace OpenAuth.App
{
    public class UserManagerApp : BaseStringApp<User,OpenAuthDBContext>
    {
        private RevelanceManagerApp _revelanceApp;
        private OrgManagerApp _orgManagerApp;
        public UserManagerApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<User,OpenAuthDBContext> repository,
            RevelanceManagerApp app,IAuth auth, OrgManagerApp orgManagerApp) : base(unitWork, repository, auth)
        {
            _revelanceApp = app;
            _orgManagerApp = orgManagerApp;
        }
        public User GetByAccount(string account)
        {
            return Repository.FirstOrDefault(u => u.Account == account);
        }
        /// <summary>
        /// 加载当前登录用户可访问的一个部门及子部门全部用户
        /// 如果请求的request.OrgId为空，则可以获取到已被删除机构的用户（即：没有分配任何机构的用户）
        /// </summary>
        public async Task<TableData> Load(QueryUserListReq request)
        {
            var loginUser = _auth.GetCurrentUser();
            IQueryable<User> query = UnitWork.Find<User>(null);
            if (!string.IsNullOrEmpty(request.key))
            {
                query = UnitWork.Find<User>(u => u.Name.Contains(request.key) || u.Account.Contains(request.key));
            }
            var userOrgs = from user in query 
                join user2 in UnitWork.Find<User>(null)
                    on user.ParentId equals user2.Id into tempuser
                from u in tempuser.DefaultIfEmpty() 
                join relevance in UnitWork.Find<Relevance>(u => u.Key == "UserOrg")
                    on user.Id equals relevance.FirstId into temp
                from r in temp.DefaultIfEmpty()
                join org in UnitWork.Find<SysOrg>(null)
                    on r.SecondId equals org.Id into orgtmp
                from o in orgtmp.DefaultIfEmpty()
                select new
                {
                    user.Account,
                    user.Name,
                    user.Id,
                    user.Sex,
                    user.Status,
                    user.BizCode,
                    user.CreateId,
                    user.CreateTime,
                    user.TypeId,
                    user.TypeName,
                    user.ParentId,
                    ParentName = u.Name, //直属上级
                    r.Key,
                    r.SecondId,
                    OrgId = o.Id,
                    OrgName = o.Name
                };
            //如果请求的orgId不为空
            if (!string.IsNullOrEmpty(request.orgId))
            {
                var org = loginUser.Orgs.SingleOrDefault(u => u.Id == request.orgId);
                var cascadeId = org.CascadeId;
                var orgIds = loginUser.Orgs.Where(u => u.CascadeId.Contains(cascadeId)).Select(u => u.Id).ToArray();
                //只获取机构里面的用户
                userOrgs = userOrgs.Where(u => u.Key == Define.USERORG && orgIds.Contains(u.OrgId));
            }
            else  //todo:如果请求的orgId为空，即为跟节点，这时可以额外获取到机构已经被删除的用户，从而进行机构分配。可以根据自己需求进行调整
            {
                var orgIds = loginUser.Orgs.Select(u => u.Id).ToArray();
                //获取用户可以访问的机构的用户和没有任何机构关联的用户（机构被删除后，没有删除这里面的关联关系）
                userOrgs = userOrgs.Where(u => (u.Key == Define.USERORG && orgIds.Contains(u.OrgId)) || (u.OrgId == null));
            }
            var userViews = (await userOrgs.ToListAsync()).GroupBy(b => b.Account)
                .Select(u =>new UserView
            {
                Id = u.First().Id,
                Account = u.Key,
                Name = u.First().Name,
                ParentName = u.First().ParentName,
                Sex = u.First().Sex,
                Status = u.First().Status,
                ParentId = u.First().ParentId,
                CreateTime = u.First().CreateTime,
                CreateUser = u.First().CreateId,
                OrganizationIds = string.Join(",", u.Select(x=>x.OrgId))
                ,Organizations = string.Join(",", u.Select(x=>x.OrgName))
            });
            return new TableData
            {
                count =userViews.Count(),
                data =userViews.OrderBy(u => u.Name)
                    .Skip((request.page - 1) * request.limit)
                    .Take(request.limit),
            };
        }
        /// <summary>
        /// 获取所有的用户
        /// 为了控制权限，通常只用于流程实例选择执行角色，其他地方请使用Load
        /// </summary>
        public async Task<TableResp<UserView>> LoadAll(QueryUserListReq request)
        {
           IQueryable<User> query = UnitWork.Find<User>(null);
           if (!string.IsNullOrEmpty(request.key))
           {
               query = UnitWork.Find<User>(u => u.Name.Contains(request.key) || u.Account.Contains(request.key));
           }
           var userOrgs = from user in query
               join user2 in UnitWork.Find<User>(null)
                   on user.ParentId equals user2.Id into tempuser
               from u in tempuser.DefaultIfEmpty() 
               join relevance in UnitWork.Find<Relevance>(u => u.Key == "UserOrg")
                   on user.Id equals relevance.FirstId into temp
               from r in temp.DefaultIfEmpty()
               join org in UnitWork.Find<SysOrg>(null)
                   on r.SecondId equals org.Id into orgtmp
               from o in orgtmp.DefaultIfEmpty()
               select new
               {
                   user.Account,
                   user.Name,
                   user.Id,
                   user.Sex,
                   user.Status,
                   user.BizCode,
                   user.CreateId,
                   user.CreateTime,
                   user.TypeId,
                   user.TypeName,
                   user.ParentId,
                   ParentName = u.Name, //直属上级
                   r.Key,
                   r.SecondId,
                   OrgId = o.Id,
                   OrgName = o.Name
               };
            //如果请求的orgId不为空
            if (!string.IsNullOrEmpty(request.orgId))
            {
                userOrgs = userOrgs.Where(u => u.Key == Define.USERORG && u.OrgId == request.orgId);
            }
            var userViews = (await userOrgs.ToListAsync()).GroupBy(b => b.Account).Select(u =>new UserView
            {
                Id = u.First().Id,
                Account = u.Key,
                Name = u.First().Name,
                Sex = u.First().Sex,
                Status = u.First().Status,
                CreateTime = u.First().CreateTime,
                CreateUser = u.First().CreateId,
                ParentName = u.First().ParentName,
                ParentId = u.First().ParentId,
                OrganizationIds = string.Join(",", u.Select(x=>x.OrgId))
                ,Organizations = string.Join(",", u.Select(x=>x.OrgName))
            });
            return new TableResp<UserView>()
            {
                count = userViews.Count(),
                data = userViews.OrderBy(u => u.Name)
                    .Skip((request.page - 1) * request.limit)
                    .Take(request.limit).ToList()
            };
        }
        public void AddOrUpdate(UpdateUserReq request)
        {
            request.ValidationEntity(u => new {u.Account,u.Name, u.OrganizationIds});
            if (string.IsNullOrEmpty(request.OrganizationIds))
                throw new Exception("请为用户分配机构");
            User requser = request;
            requser.CreateId = _auth.GetCurrentUser().User.Id;
            UnitWork.ExecuteWithTransaction(() =>
            {
                if (string.IsNullOrEmpty(request.Id))
                {
                    if (UnitWork.Any<User>(u => u.Account == request.Account))
                    {
                        throw new Exception("用户账号已存在");
                    }
                    if (string.IsNullOrEmpty(requser.Password))
                    {
                        requser.Password = requser.Account;   //如果客户端没提供密码，默认密码同账号
                    }
                    requser.CreateTime = DateTime.Now;
                    UnitWork.Add(requser);
                    request.Id = requser.Id; //要把保存后的ID存入view
                }
                else
                {
                    UnitWork.Update<User>(u => u.Id == request.Id, u => new User
                    {
                        Account = requser.Account,
                        BizCode = requser.BizCode,
                        Name = requser.Name,
                        Sex = requser.Sex,
                        Status = requser.Status,
                        ParentId = request.ParentId
                    });
                    if (!string.IsNullOrEmpty(requser.Password))  //密码为空的时候，不做修改
                    {
                        UnitWork.Update<User>(u => u.Id == request.Id, u => new User
                        {
                            Password = requser.Password
                        });
                    }
                }
                UnitWork.Save();
                string[] orgIds = request.OrganizationIds.Split(',').ToArray();
                _revelanceApp.DeleteBy(Define.USERORG, requser.Id);
                _revelanceApp.Assign(Define.USERORG, orgIds.ToLookup(u => requser.Id));
            });
        }
        /// <summary>
        /// 删除用户,包含用户与组织关系、用户与角色关系
        /// </summary>
        /// <param name="ids"></param>
        public override void Delete(string[] ids)
        {
            UnitWork.ExecuteWithTransaction(() =>
            {
                UnitWork.Delete<Relevance>(u =>(u.Key == Define.USERROLE || u.Key == Define.USERORG) 
                                               && ids.Contains(u.FirstId));
                UnitWork.Delete<User>(u => ids.Contains(u.Id));
                UnitWork.Save();
            });
        }
        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="request"></param>
        public void ChangePassword(ChangePasswordReq request)
        {
            Repository.Update(u => u.Account == request.Account, user => new User
            {
                Password = request.Password
            });
        }
        /// <summary>
        /// 获取指定角色包含的用户列表
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public async Task<TableData> LoadByRole(QueryUserListByRoleReq request)
        {
            var users = from userRole in UnitWork.Find<Relevance>(u =>
                    u.SecondId == request.roleId && u.Key == Define.USERROLE)
                join user in UnitWork.Find<User>(null) on userRole.FirstId equals user.Id into temp
                from c in temp.Where(u =>u.Id != null)
                select c;
            return new TableData
            {
                count =await users.CountAsync(),
                data =await users.Skip((request.page - 1) * request.limit).Take(request.limit).ToListAsync()
            };
        }
        /// <summary>
        /// 获取指定机构包含的用户列表
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public async Task<TableData> LoadByOrg(QueryUserListByOrgReq request)
        {
            var users = from userOrg in UnitWork.Find<Relevance>(u =>
                    u.SecondId == request.orgId && u.Key == Define.USERORG)
                join user in UnitWork.Find<User>(null) on userOrg.FirstId equals user.Id into temp
                from c in temp.Where(u =>u.Id != null)
                select c;
            return new TableData
            {
                count =await users.CountAsync(),
                data =await users.Skip((request.page - 1) * request.limit).Take(request.limit).ToListAsync()
            };
        }
        /// <summary>
        /// 修改用户资料
        /// </summary>
        /// <param name="request"></param>
        public void ChangeProfile(ChangeProfileReq request)
        {
            if (request.Account == Define.SYSTEM_USERNAME)
            {
                throw new Exception("不能修改超级管理员信息");
            }
            Repository.Update(u => u.Account == request.Account, user => new User
                        {
                            Name = request.Name,
                            Sex = request.Sex
                        });
        }
        
        /// <summary>
        /// 获取用户的直属上级ID
        /// </summary>
        /// <param name="userid">用户ID</param>
        /// <returns></returns>
        public string GetParent(string userid)
        {
            if (userid == Guid.Empty.ToString())
            {
                throw new Exception("超级管理员没有直属上级，请检查配置");
            }
            return Repository.FirstOrDefault(u => u.Id == userid).ParentId;
        }


        /// <summary>
        /// 获取流程实例通知的用户
        /// </summary>
        /// <param name="instanceId"></param>
        /// <returns></returns>
        public List<string> GetNoticeUsers(string instanceId)
        {
            var sql = $@"
            select u.*
            from `USER` u
                     join (select distinct SecondId as UserId
                           from Relevance
                           where `Key` = '{Define.INSTANCE_NOTICE_USER}'
                             and FirstId = '{instanceId}'
                           union
                           select distinct FirstId as UserId
                           from Relevance a
                                    inner join (select SecondId as RoleId
                                                from Relevance
                                                where `Key` = '{Define.INSTANCE_NOTICE_ROLE}'
                                                  and FirstId = '{instanceId}') b on a.SecondId = b.RoleId
                           where `Key` = 'UserRole') userids on u.Id = userids.UserId";

            if (UnitWork.GetDbContext().Database.GetDbConnection().GetType().Name == "SqlConnection")
            {
                sql = sql.Replace(" `USER` ", " [USER] ");
                sql = sql.Replace("`Key`", "[Key]");
            }
            else if (UnitWork.GetDbContext().Database.GetDbConnection().GetType().Name == "OracleConnection")
            {
                sql = sql.Replace(" `USER` ", " \"USER\" ");
                sql = sql.Replace("`Key`", "\"Key\"");
            }
            
            var users = UnitWork.FromSql<User>(sql);
            return users.Select(u=>u.Id).ToList();
        }
    }
}