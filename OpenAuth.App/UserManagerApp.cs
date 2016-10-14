using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;


namespace OpenAuth.App
{
    public class UserManagerApp
    {
        private IUserRepository _repository;
        private IOrgRepository _orgRepository;
        private IRelevanceRepository _relevanceRepository;

        public UserManagerApp(IUserRepository repository,
            IOrgRepository orgRepository,
            IRelevanceRepository relevanceRepository)
        {
            _repository = repository;
            _orgRepository = orgRepository;
            _relevanceRepository = relevanceRepository;
        }

        public User Get(string  account)
        {
            return _repository.FindSingle(u => u.Account == account);
        }

        public int GetUserCntInOrg(Guid orgId)
        {
            if (orgId == Guid.Empty)
            {
                return _repository.Find(null).Count();
            }
            else
            {
                return _repository.GetUserCntInOrgs(GetSubOrgIds(orgId));
            }
        }

        /// <summary>
        /// 加载一个部门及子部门全部用户
        /// </summary>
        public GridData Load(Guid orgId, int pageindex, int pagesize)
        {
            if (pageindex < 1) pageindex = 1;  //TODO:如果列表为空新增加一个用户后，前端会传一个0过来，奇怪？？
            IEnumerable<User> users;
            int records = 0;
            if (orgId ==Guid.Empty)
            {
                users = _repository.LoadUsers(pageindex, pagesize);
                records = _repository.GetCount();
            }
            else
            {
                var ids = GetSubOrgIds(orgId);
                users = _repository.LoadInOrgs(pageindex, pagesize, ids);
                records = _repository.GetUserCntInOrgs(ids);
            }
            var userviews = new List<UserView>();
            foreach (var user in users)
            {
                UserView uv = user;
                var orgs = _orgRepository.LoadByUser(user.Id);
                uv.Organizations = string.Join(",", orgs.Select(u => u.Name).ToList());
                uv.OrganizationIds = string.Join(",", orgs.Select(u => u.Id).ToList());
                userviews.Add(uv);
            }

            return new GridData
            {
                records = records,
                total = (int)Math.Ceiling((double)records / pagesize),
                rows = userviews,
                page = pageindex
            };
        }

        /// <summary>
        /// 获取当前组织的所有下级组织
        /// </summary>
        private Guid[] GetSubOrgIds(Guid orgId)
        {
            var org = _orgRepository.FindSingle(u => u.Id == orgId);
            var orgs = _orgRepository.Find(u => u.CascadeId.Contains(org.CascadeId)).Select(u => u.Id).ToArray();
            return orgs;
        }

        public UserView Find(Guid id)
        {
            var user = _repository.FindSingle(u => u.Id == id);
            if (user == null) return new UserView();

            UserView view = user;
            foreach (var org in _orgRepository.LoadByUser(id))
            {
                view.Organizations += "," + org.Name;
                view.OrganizationIds += "," + org.Id;
            }
            view.OrganizationIds = view.OrganizationIds.TrimStart(',');
            view.Organizations = view.Organizations.TrimStart(',');
            return view;
        }

        public void Delete(Guid[] ids)
        {
            _repository.Delete(u => ids.Contains(u.Id));
            _relevanceRepository.DeleteBy("UserOrg", ids);
            _relevanceRepository.DeleteBy("UserModule", ids);
            _relevanceRepository.DeleteBy("UserRole", ids);
        }

        public void AddOrUpdate(UserView view)
        {
            User user = view;
            if (user.Id == Guid.Empty)
            {
                if (_repository.IsExist(u => u.Account == view.Account))
                {
                    throw new Exception("用户账号已存在");
                }
                user.CreateTime = DateTime.Now;
                user.Password = user.Account; //初始密码与账号相同
                _repository.Add(user);
                view.Id = user.Id;   //要把保存后的ID存入view
            }
            else
            {
                _repository.Update(u => u.Id == view.Id, u => new User
                {
                    Account = user.Account,
                    BizCode = user.BizCode,
                    Name = user.Name,
                    Sex = user.Sex,
                    Status = user.Status,
                    Type = user.Type
                });
            }
            Guid[] orgIds = view.OrganizationIds.Split(',').Select(id => Guid.Parse(id)).ToArray();

            _relevanceRepository.DeleteBy("UserOrg", user.Id);
            _relevanceRepository.AddRelevance("UserOrg", orgIds.ToLookup(u => user.Id));
        }

        public IEnumerable<User> GetUsers(IEnumerable<Guid> userids)
        {
            return _repository.Find(u => userids.Contains(u.Id));
        }
    }
}