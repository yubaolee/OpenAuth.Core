using OpenAuth.App.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.Request;
using OpenAuth.Repository.Domain;


namespace OpenAuth.App
{
    public class UserManagerApp :BaseApp<User>
    {
        public RevelanceManagerApp ReleManagerApp { get; set; }


        public User Get(string  account)
        {
            return Repository.FindSingle(u => u.Account == account);
        }


        /// <summary>
        /// 加载一个部门及子部门全部用户
        /// </summary>
        public GridData Load(QueryUserListReq request)
        {
            IEnumerable<User> users;
            int records = 0;
            if (string.IsNullOrEmpty(request.orgId))
            {
                users = UnitWork.Find<User>(null).OrderBy(u => u.Id).Skip((request.page - 1) * request.limit).Take(request.limit);
                records = UnitWork.GetCount<User>();
            }
            else
            {
                var ids = GetSubOrgIds(request.orgId);
                List<string> userIds = ReleManagerApp.Get("UserOrg", false, ids);
                users = UnitWork.Find<User>(u =>userIds.Contains(u.Id))
                    .OrderBy(u => u.Name)
                    .Skip((request.page - 1) * request.limit)
                    .Take(request.limit);
                records = UnitWork.GetCount<User>();
            }

            var userviews = new List<UserView>();
            foreach (var user in users)
            {
                UserView uv = user; 
                var orgs = LoadByUser(user.Id);
                uv.Organizations = string.Join(",", orgs.Select(u => u.Name).ToList());
                uv.OrganizationIds = string.Join(",", orgs.Select(u => u.Id).ToList());
                userviews.Add(uv);
            }

            return new GridData
            {
                count = records,
                data = userviews,
            };
        }

        /// <summary>
        /// 获取当前组织的所有下级组织
        /// </summary>
        private string[] GetSubOrgIds(string orgId)
        {
            var org = UnitWork.FindSingle<Org>(u => u.Id == orgId);
            var orgs = UnitWork.Find<Org>(u => u.CascadeId.Contains(org.CascadeId))
                .Select(u => u.Id).ToArray();
            return orgs;
        }

        public UserView Find(string id)
        {
            var user = Repository.FindSingle(u => u.Id == id);
            if (user == null) return new UserView();

            UserView view = user;
            foreach (var org in LoadByUser(id))
            {
                view.Organizations += "," + org.Name;
                view.OrganizationIds += "," + org.Id;
            }
            view.OrganizationIds = view.OrganizationIds.TrimStart(',');
            view.Organizations = view.Organizations.TrimStart(',');
            return view;
        }

        public void Delete(string[] ids)
        {
           Repository.Delete(u => ids.Contains(u.Id));
        }

        public void AddOrUpdate(UserView view)
        {
            if (string.IsNullOrEmpty(view.OrganizationIds))
                throw new Exception("请为用户分配机构");
            User user = view;
            if (string.IsNullOrEmpty(view.Id))
            {
                if (UnitWork.IsExist<User>(u => u.Account == view.Account))
                {
                    throw new Exception("用户账号已存在");
                }
                user.CreateTime = DateTime.Now;
                user.Password = user.Account; //初始密码与账号相同
                Repository.Add(user);
                view.Id = user.Id;   //要把保存后的ID存入view
            }
            else
            {
                UnitWork.Update<User>(u => u.Id == view.Id, u => new User
                {
                    Account = user.Account,
                    BizCode = user.BizCode,
                    Name = user.Name,
                    Sex = user.Sex,
                    Status = user.Status
                });
            }
            string[] orgIds = view.OrganizationIds.Split(',').ToArray();

            ReleManagerApp.DeleteBy("UserOrg", user.Id);
            ReleManagerApp.AddRelevance("UserOrg", orgIds.ToLookup(u => user.Id));
        }

        /// <summary>
        /// 加载用户的所有机构
        /// </summary>
        public IEnumerable<Org> LoadByUser(string userId)
        {
            var result = from userorg in UnitWork.Find<Relevance>(null)
                join org in UnitWork.Find<Org>(null) on userorg.SecondId equals org.Id
                where userorg.FirstId == userId && userorg.Key == "UserOrg"
                select org;
            return result;
        }


    }
}