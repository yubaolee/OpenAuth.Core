using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.ViewModel;

namespace OpenAuth.App
{
    public class OrgManagerApp
    {
        private IOrgRepository _repository;
        private IRelevanceRepository _relevanceRepository;

        public OrgManagerApp(IOrgRepository repository, IRelevanceRepository relevanceRepository)
        {
            _repository = repository;
            _relevanceRepository = relevanceRepository;
        }

        public IList<Org> GetAll()
        {
            return _repository.LoadOrgs().ToList();
        }

        /// <summary>
        /// 部门的直接子部门
        /// <para>TODO:可以根据用户的喜好决定选择LoadAllChildren或LoadDirectChildren</para>
        /// </summary>
        /// <param name="orgId">The org unique identifier.</param>
        /// <returns>IEnumerable{Org}.</returns>
        public IList<Org> LoadDirectChildren(string orgId)
        {
            return _repository.Find(u => u.ParentId == orgId).ToList();
        }

        /// <summary>
        /// 得到部门的所有子部门
        /// <para>如果orgId为0，表示取得所有部门</para>
        /// </summary>
        public GridData LoadAllChildren(string orgId)
        {
            var query = _repository.GetSubOrgs(orgId);
            return new GridData
            {
                page = 1,
                data = query.ToList(),
                count = query.Count(),
                total = 1
            };
        }


        /// <summary>
        /// 添加部门
        /// </summary>
        /// <param name="org">The org.</param>
        /// <returns>System.Int32.</returns>
        /// <exception cref="System.Exception">未能找到该组织的父节点信息</exception>
        public string AddOrUpdate(Org org)
        {
            ChangeModuleCascade(org);
            if (org.Id == string.Empty)
            {
                _repository.Add(org);
            }
            else
            {
                //获取旧的的CascadeId
                var CascadeId = _repository.FindSingle(o => o.Id == org.Id).CascadeId;
                //根据CascadeId查询子部门
                var orgs = _repository.Find(u => u.CascadeId.Contains(CascadeId) && u.Id != org.Id).OrderBy(u => u.CascadeId).ToList();

                //更新操作
                _repository.Update(org);

                //更新子部门的CascadeId
                foreach (var a in orgs)
                {
                    ChangeModuleCascade(a);
                    _repository.Update(a);
                }
            }

            return org.Id;
        }

        /// <summary>
        /// 删除指定ID的部门及其所有子部门
        /// </summary>
        public void DelOrg(string[] ids)
        {
            var delOrg = _repository.Find(u => ids.Contains(u.Id)).ToList();
            foreach (var org in delOrg)
            {
                _repository.Delete(u => u.CascadeId.Contains(org.CascadeId));
            }
        }


        /// <summary>
        /// 加载特定用户的角色
        /// TODO:这里会加载用户及用户角色的所有角色，“为用户分配角色”功能会给人一种混乱的感觉，但可以接受
        /// </summary>
        /// <param name="userId">The user unique identifier.</param>
        public List<Org> LoadForUser(string userId)
        {
            //用户角色
            var userRoleIds =
                _relevanceRepository.Find(u => u.FirstId == userId && u.Key == "UserRole").Select(u => u.SecondId).ToList();

            //用户角色与自己分配到的角色ID
            var moduleIds =
                _relevanceRepository.Find(
                    u =>
                        (u.FirstId == userId && u.Key == "UserOrg") ||
                        (u.Key == "RoleOrg" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();

            if (!moduleIds.Any()) return new List<Org>();
            return _repository.Find(u => moduleIds.Contains(u.Id)).ToList();
        }

        /// <summary>
        /// 加载特定角色的角色
        /// </summary>
        /// <param name="roleId">The role unique identifier.</param>
        public List<Org> LoadForRole(string roleId)
        {
            var moduleIds =
                _relevanceRepository.Find(u => u.FirstId == roleId && u.Key == "RoleOrg")
                    .Select(u => u.SecondId)
                    .ToList();
            if (!moduleIds.Any()) return new List<Org>();
            return _repository.Find(u => moduleIds.Contains(u.Id)).ToList();
        }

        #region 私有方法

        //修改对象的级联ID，生成类似XXX.XXX.X.XX
        private void ChangeModuleCascade(Org org)
        {
            string cascadeId;
            int currentCascadeId = 1;  //当前结点的级联节点最后一位
            var sameLevels = _repository.Find(o => o.ParentId == org.ParentId && o.Id != org.Id);
            foreach (var obj in sameLevels)
            {
                int objCascadeId = int.Parse(obj.CascadeId.TrimEnd('.').Split('.').Last());
                if (currentCascadeId <= objCascadeId) currentCascadeId = objCascadeId + 1;
            }

            if (org.ParentId != null && org.ParentId != string.Empty)
            {
                var parentOrg = _repository.FindSingle(o => o.Id == org.ParentId);
                if (parentOrg != null)
                {
                    cascadeId = parentOrg.CascadeId + currentCascadeId+".";
                    org.ParentName = parentOrg.Name;
                }
                else
                {
                    throw new Exception("未能找到该组织的父节点信息");
                }
            }
            else
            {
                cascadeId = ".0." + currentCascadeId+".";
                org.ParentName = "根节点";
            }

            org.CascadeId = cascadeId;
        }

        #endregion 私有方法
    }
}