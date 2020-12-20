using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Castle.Core.Internal;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class UserManagerApp : BaseApp<User>
    {
        private RevelanceManagerApp _revelanceApp;
        private OrgManagerApp _orgManagerApp;
        
        public UserManagerApp(IUnitWork unitWork, IRepository<User> repository,
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
                join relevance in UnitWork.Find<Relevance>(u =>u.Key=="UserOrg")
                    on user.Id equals relevance.FirstId into temp
                from r in temp.DefaultIfEmpty()
                join org in UnitWork.Find<Org>(null)
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
                    r.Key,
                    r.SecondId,
                    OrgId = o.Id,
                    OrgName= o.Name
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

           
            
            var userViews = userOrgs.ToList().GroupBy(b => b.Account).Select(u =>new UserView
            {
                Id = u.First().Id,
                Account = u.Key,
                Name = u.First().Name,
                Sex = u.First().Sex,
                Status = u.First().Status,
                CreateTime = u.First().CreateTime,
                CreateUser = u.First().CreateId,
                OrganizationIds = string.Join(",", u.Select(x=>x.OrgId))
                ,Organizations = string.Join(",", u.Select(x=>x.OrgName))
                
            });

            return new TableData
            {
                count = userViews.Count(),
                data = userViews.OrderBy(u => u.Name)
                    .Skip((request.page - 1) * request.limit)
                    .Take(request.limit),
            };
        }

        public void AddOrUpdate(UpdateUserReq request)
        {
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
                        Status = requser.Status
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
                count = users.Count(),
                data = users.Skip((request.page - 1) * request.limit).Take(request.limit)
            };
        }
        
        /// <summary>
        /// 获取指定机构包含的用户列表
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public async Task<TableData> LoadByOrg(QueryUserListByOrgReq request)
        {
            var users = from userRole in UnitWork.Find<Relevance>(u =>
                    u.SecondId == request.orgId && u.Key == Define.USERORG)
                join user in UnitWork.Find<User>(null) on userRole.FirstId equals user.Id into temp
                from c in temp.Where(u =>u.Id != null)
                select c;

            return new TableData
            {
                count = users.Count(),
                data = users.Skip((request.page - 1) * request.limit).Take(request.limit)
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
    }
}