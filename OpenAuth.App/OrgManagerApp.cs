using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.App
{
    public class OrgManagerApp
    {
        private IOrgRepository _repository;

        public OrgManagerApp(IOrgRepository repository)
        {
            _repository = repository;
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
        public IList<Org> LoadDirectChildren(int orgId)
        {
            return _repository.Find(u => u.ParentId == orgId).ToList();
        }

        /// <summary>
        /// 得到部门的所有子部门
        /// <para>如果orgId为0，表示取得所有部门</para>
        /// </summary>
        public IList<Org> LoadAllChildren(int orgId)
        {
            string cascadeId = "0.";
            if (orgId != 0)
            {
                var org = _repository.FindSingle(u => u.Id == orgId);
                if (org == null)
                    throw new Exception("未能找到指定对象信息");
                cascadeId = org.CascadeId;
            }

            return _repository.Find(u => u.CascadeId.Contains(cascadeId) && u.Id != orgId).ToList();
        }

        /// <summary>
        /// 添加部门
        /// </summary>
        /// <param name="org">The org.</param>
        /// <returns>System.Int32.</returns>
        /// <exception cref="System.Exception">未能找到该组织的父节点信息</exception>
        public int AddOrUpdate(Org org)
        {
            if (org.Id == 0)
            {
                ChangeModuleCascade(org);
                _repository.Add(org);
            }
            else
            {
                _repository.Update(org);
            }

            return org.Id;
        }

        /// <summary>
        /// 删除指定ID的部门及其所有子部门
        /// </summary>
        public void DelOrg(int id)
        {
            var delOrg = _repository.FindSingle(u => u.Id == id);
            if (delOrg == null) return;

            _repository.Delete(u => u.CascadeId.Contains(delOrg.CascadeId));
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
                int objCascadeId = int.Parse(obj.CascadeId.Split('.').Last());
                if (currentCascadeId <= objCascadeId) currentCascadeId = objCascadeId + 1;
            }

            if (org.ParentId != 0)
            {
                var parentOrg = _repository.FindSingle(o => o.Id == org.ParentId);
                if (parentOrg != null)
                {
                    cascadeId = parentOrg.CascadeId + "." + currentCascadeId;
                    org.ParentName = parentOrg.Name;
                }
                else
                {
                    throw new Exception("未能找到该组织的父节点信息");
                }
            }
            else
            {
                cascadeId = "0." + currentCascadeId;
                org.ParentName = "根节点";
            }

            org.CascadeId = cascadeId;
        }

        #endregion 私有方法
    }
}