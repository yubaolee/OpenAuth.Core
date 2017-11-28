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
          public IUnitWork _unitWork { get; set; }

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
                _unitWork.Add(org);
            }
            else
            {
                //获取旧的的CascadeId
                var CascadeId = _unitWork.FindSingle<Org>(o => o.Id == org.Id).CascadeId;
                //根据CascadeId查询子部门
                var orgs = _unitWork.Find<Org>(u => u.CascadeId.Contains(CascadeId) && u.Id != org.Id).OrderBy(u => u.CascadeId).ToList();

                //更新操作
                _unitWork.Update(org);

                //更新子部门的CascadeId
                foreach (var a in orgs)
                {
                    ChangeModuleCascade(a);
                    _unitWork.Update(a);
                }
            }

            return org.Id;
        }

        /// <summary>
        /// 删除指定ID的部门及其所有子部门
        /// </summary>
        public void DelOrg(string[] ids)
        {
            var delOrg = _unitWork.Find<Org>(u => ids.Contains(u.Id)).ToList();
            foreach (var org in delOrg)
            {
                _unitWork.Delete<Org>(u => u.CascadeId.Contains(org.CascadeId));
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
                _unitWork.Find<Relevance>(u => u.FirstId == userId && u.Key == "UserRole").Select(u => u.SecondId).ToList();

            //用户角色与自己分配到的角色ID
            var moduleIds =
                _unitWork.Find<Relevance>(
                    u =>
                        (u.FirstId == userId && u.Key == "UserOrg") ||
                        (u.Key == "RoleOrg" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();

            if (!moduleIds.Any()) return new List<Org>();
            return _unitWork.Find<Org>(u => moduleIds.Contains(u.Id)).ToList();
        }

        /// <summary>
        /// 加载特定角色的角色
        /// </summary>
        /// <param name="roleId">The role unique identifier.</param>
        public List<Org> LoadForRole(string roleId)
        {
            var moduleIds =
                _unitWork.Find<Relevance>(u => u.FirstId == roleId && u.Key == "RoleOrg")
                    .Select(u => u.SecondId)
                    .ToList();
            if (!moduleIds.Any()) return new List<Org>();
            return _unitWork.Find<Org>(u => moduleIds.Contains(u.Id)).ToList();
        }


        /// <summary>
        /// 得到部门的所有子部门
        /// <para>如果orgId为0，表示取得所有部门</para>
        /// </summary>
        public GridData LoadAllChildren(string orgId)
        {
            var query = GetSubOrgs(orgId);
            return new GridData
            {
                data = query.ToList(),
                count = query.Count(),
            };
        }

        public IEnumerable<Org> GetSubOrgs(string orgId)
        {
            string cascadeId = "0.";
            if (!string.IsNullOrEmpty(orgId))
            {
                var org = _unitWork.FindSingle<Org>(u => u.Id == orgId);
                if (org == null)
                    throw new Exception("未能找到指定对象信息");
                cascadeId = org.CascadeId;
            }

            return _unitWork.Find<Org>(u => u.CascadeId.Contains(cascadeId));
        }

        #region 私有方法

        //修改对象的级联ID，生成类似XXX.XXX.X.XX
        private void ChangeModuleCascade(Org org)
        {
            string cascadeId;
            int currentCascadeId = 1;  //当前结点的级联节点最后一位
            var sameLevels = _unitWork.Find<Org>(o => o.ParentId == org.ParentId && o.Id != org.Id);
            foreach (var obj in sameLevels)
            {
                int objCascadeId = int.Parse(obj.CascadeId.TrimEnd('.').Split('.').Last());
                if (currentCascadeId <= objCascadeId) currentCascadeId = objCascadeId + 1;
            }

            if (org.ParentId != null && org.ParentId != string.Empty)
            {
                var parentOrg = _unitWork.FindSingle<Org>(o => o.Id == org.ParentId);
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