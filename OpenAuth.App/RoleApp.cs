using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class RoleApp : BaseApp<Role>
    {
        private RevelanceManagerApp _revelanceApp;

        private IAuth _auth;

        /// <summary>
        /// 加载当前登录用户可访问的一个部门及子部门全部角色
        /// </summary>
        public TableData Load(QueryRoleListReq request)
        {
            var loginUser = _auth.GetCurrentUser();

            string cascadeId = ".0.";
            if (!string.IsNullOrEmpty(request.orgId))
            {
                var org = loginUser.Orgs.SingleOrDefault(u => u.Id == request.orgId);
                cascadeId = org.CascadeId;
            }

            var ids = loginUser.Orgs.Where(u => u.CascadeId.Contains(cascadeId)).Select(u => u.Id).ToArray();
            var roleIds = _revelanceApp.Get(Define.ROLEORG, false, ids);

            var roles = UnitWork.Find<Role>(u => roleIds.Contains(u.Id))
                   .OrderBy(u => u.Name)
                   .Skip((request.page - 1) * request.limit)
                   .Take(request.limit);

            var records = Repository.GetCount(u => roleIds.Contains(u.Id));


            var roleViews = new List<RoleView>();
            foreach (var role in roles.ToList())
            {
                RoleView uv = role;
                var orgs = LoadByRole(role.Id);
                uv.Organizations = string.Join(",", orgs.Select(u => u.Name).ToList());
                uv.OrganizationIds = string.Join(",", orgs.Select(u => u.Id).ToList());
                roleViews.Add(uv);
            }

            return new TableData
            {
                count = records,
                data = roleViews,
            };
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


        public void Add(RoleView obj)
        {
            if (string.IsNullOrEmpty(obj.OrganizationIds))
                throw new Exception("请为角色分配机构");
            Role role = obj;
            role.CreateTime = DateTime.Now;
            Repository.Add(role);
            obj.Id = role.Id;   //要把保存后的ID存入view

            UpdateRele(obj);
        }
        
        public void Update(RoleView obj)
        {
            if (string.IsNullOrEmpty(obj.OrganizationIds))
                throw new Exception("请为角色分配机构");
            Role role = obj;

            UnitWork.Update<Role>(u => u.Id == obj.Id, u => new Role
            {
                Name = role.Name,
                Status = role.Status
            });

            UpdateRele(obj);
        }

        /// <summary>
        /// 更新相应的多对多关系
        /// </summary>
        /// <param name="view"></param>
        private void UpdateRele(RoleView view)
        {
            string[] orgIds = view.OrganizationIds.Split(',').ToArray();
            _revelanceApp.DeleteBy(Define.ROLEORG, view.Id);
            _revelanceApp.Assign(Define.ROLEORG, orgIds.ToLookup(u => view.Id));
        }

        public RoleApp(IUnitWork unitWork, IRepository<Role> repository,
            RevelanceManagerApp app, IAuth auth) : base(unitWork, repository)
        {
            _revelanceApp = app;
            _auth = auth;
        }
    }
}