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

        public IEnumerable<Org> GetAll()
        {
            return _repository.LoadOrgs();
        }

        /// <summary>
        /// 添加部门
        /// </summary>
        /// <param name="org">The org.</param>
        /// <returns>System.Int32.</returns>
        /// <exception cref="System.Exception">未能找到该组织的父节点信息</exception>
        public int AddOrg(Org org)
        {
            string cascadeId;
            int currentCascadeId = GetMaxCascadeId(org.ParentId);

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
                org.ParentName = "";
            }

            org.CascadeId = cascadeId;
            org.CreateTime = DateTime.Now;
            _repository.Add(org);
            _repository.Save();
            return org.Id;
        }

        /// <summary>
        /// 部门的直接子部门
        /// <para>TODO:可以根据用户的喜好决定选择LoadAllChildren或LoadDirectChildren</para>
        /// </summary>
        /// <param name="orgId">The org unique identifier.</param>
        /// <returns>IEnumerable{Org}.</returns>
        public IEnumerable<Org> LoadDirectChildren(int orgId)
        {
            return _repository.Find(u => u.ParentId == orgId);
        }

        //得到部门的所有子部门
        public IEnumerable<Org> LoadAllChildren(int orgId)
        {
            var org = _repository.FindSingle(u => u.Id == orgId);
            if (org == null)
                throw new Exception("未能找到指定对象信息");

            return _repository.Find(u => u.CascadeId.Contains(org.CascadeId) && u.Id != orgId);
        }

        /// <summary>
        /// 删除指定ID的部门及其所有子部门
        /// </summary>
        public void DelOrg(int id)
        {
            var delOrg = _repository.FindSingle(u => u.Id == id);
            if (delOrg == null)
                throw new Exception("未能找到要删除的对象");

            _repository.Delete(u => u.CascadeId.Contains(delOrg.CascadeId));
        }

        #region 私有方法

        //根据同一级中最大的语义ID
        private int GetMaxCascadeId(int parentId)
        {
            int currentCascadeId = 1;

            var maxCascadeIdOrg = _repository.Find(o => o.ParentId == parentId)
                .OrderByDescending(o => o.CascadeId).FirstOrDefault();
            if (maxCascadeIdOrg != null)
            {
                var cascades = maxCascadeIdOrg.CascadeId.Split('.');
                currentCascadeId = int.Parse(cascades[cascades.Length - 1]) + 1;
            }
            return currentCascadeId;
        }

        #endregion 私有方法
    }
}