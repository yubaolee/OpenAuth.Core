using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;


namespace OpenAuth.App
{
    public class RoleApp : BaseApp<Role>
    {
        public RevelanceManagerApp ReleManagerApp { get; set; }

        /// <summary>
        /// 加载当前登录用户可访问的一个部门及子部门全部角色
        /// </summary>
        public TableData Load(QueryRoleListReq request)
        {
            var loginUser = AuthUtil.GetCurrentUser();

            string cascadeId = ".0.";
            if (!string.IsNullOrEmpty(request.orgId))
            {
                var org = loginUser.Orgs.SingleOrDefault(u => u.Id == request.orgId);
                cascadeId = org.CascadeId;
            }

            var ids = loginUser.Orgs.Where(u => u.CascadeId.Contains(cascadeId)).Select(u => u.Id).ToArray();
            var roleIds = ReleManagerApp.Get(Define.ROLEORG, false, ids);

            var roles = UnitWork.Find<Role>(u => roleIds.Contains(u.Id))
                   .OrderBy(u => u.Name)
                   .Skip((request.page - 1) * request.limit)
                   .Take(request.limit);

            var records = Repository.GetCount(u => roleIds.Contains(u.Id));


            var userviews = new List<RoleView>();
            foreach (var role in roles)
            {
                RoleView uv = role;
                var orgs = LoadByRole(role.Id);
                uv.Organizations = string.Join(",", orgs.Select(u => u.Name).ToList());
                uv.OrganizationIds = string.Join(",", orgs.Select(u => u.Id).ToList());
                userviews.Add(uv);
            }

            return new TableData
            {
                count = records,
                data = userviews,
            };
        }

        public void AddOrUpdate(RoleView view)
        {
            if (string.IsNullOrEmpty(view.OrganizationIds))
                throw new Exception("请为用户分配机构");
            Role role = view;
            if (string.IsNullOrEmpty(view.Id))
            {
                if (UnitWork.IsExist<User>(u => u.Account == view.Name))
                {
                    throw new Exception("用户账号已存在");
                }
                role.CreateTime = DateTime.Now;
                Repository.Add(role);
                view.Id = role.Id;   //要把保存后的ID存入view
            }
            else
            {
                UnitWork.Update<User>(u => u.Id == view.Id, u => new User
                {
                    Name = role.Name,
                    Status = role.Status
                });
            }
            string[] orgIds = view.OrganizationIds.Split(',').ToArray();

            ReleManagerApp.DeleteBy(Define.ROLEORG, role.Id);
            ReleManagerApp.AddRelevance(Define.ROLEORG, orgIds.ToLookup(u => role.Id));
        }

        /// <summary>
        /// 加载角色的所有机构
        /// </summary>
        public IEnumerable<Org> LoadByRole(string roleId)
        {
            var result = from userorg in UnitWork.Find<Relevance>(null)
                         join org in UnitWork.Find<Org>(null) on userorg.SecondId equals org.Id
                         where userorg.FirstId == roleId && userorg.Key == Define.ROLEORG
                         select org;
            return result;
        }


    }
}