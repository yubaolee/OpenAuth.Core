using System;
using System.Collections.Generic;
using System.Linq;
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
            int currentCascadeId = 1;
           

            if (org.ParentId != 0)
            {
                //根据同一级中最大的语义ID
                var maxCascadeIdOrg = _repository.Find(o => o.ParentId == org.ParentId)
                    .OrderByDescending(o =>o.CascadeId).FirstOrDefault();
                if (maxCascadeIdOrg != null)
                {
                    var cascades = maxCascadeIdOrg.CascadeId.Split('.');
                    currentCascadeId = int.Parse(cascades[cascades.Length - 1]) + 1;
                }
               
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
