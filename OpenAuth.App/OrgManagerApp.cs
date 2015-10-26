using System;
using System.Collections.Generic;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

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

        public int AddOrg(Org org)
        {
            string cascadeId;
            //根据同一级个数计算ID
            int currentCascadeId = _repository.GetCount(o => o.ParentId == 0) + 1;

            if (org.ParentId != 0)
            {
                var parentOrg = _repository.FindSingle(o => o.Id == org.ParentId);
                if (parentOrg != null)
                {
                    cascadeId = parentOrg.CascadeId +"." + currentCascadeId;
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
    }
}
