using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Domain.Service
{
    /// <summary>
    /// 流程设计服务
    /// <para>李玉宝新增于2017-01-16 16:18:35</para>
    /// </summary>
    public class WFSchemeService
    {
        protected IUnitWork _unitWork;

        public WFSchemeService(IUnitWork unitWork)
        {
            _unitWork = unitWork;
        }

        /// <summary>
        /// 保存流程
        /// </summary>
        /// <param name="entity">表单模板实体类</param>
        /// <param name="keyValue">主键</param>
        /// <returns></returns>
        public int SaveForm(string keyValue, WFSchemeInfo entity, WFSchemeContent modelentity)
        {
            try
            {
                if (string.IsNullOrEmpty(keyValue))
                {
                    entity.SchemeVersion = DateTime.Now.ToString("yyyyMMddHHmmssffff");
                    _unitWork.Add(entity);

                    modelentity.SchemeInfoId = entity.Id;
                    modelentity.SchemeVersion = entity.SchemeVersion;
                    _unitWork.Add(modelentity);
                }
                else
                {
                    Guid schemeid = Guid.Parse(keyValue);
                    WFSchemeContent modelentityold =
                        _unitWork.FindSingle<WFSchemeContent>(u => u.SchemeVersion == entity.SchemeVersion
                                                                   && u.SchemeInfoId == schemeid); 

                    if (modelentityold.SchemeContent != modelentity.SchemeContent)
                    {
                        if (modelentity.SchemeVersion == "cg")
                        {
                            modelentityold.SchemeContent = modelentity.SchemeContent;
                            modelentityold.SchemeVersion = DateTime.Now.ToString("yyyyMMddHHmmssffff");
                            modelentity.SchemeVersion = modelentityold.SchemeVersion;
                            _unitWork.Update(modelentityold);
                        }
                        else
                        {
                            modelentity.SchemeInfoId = schemeid;
                            modelentity.SchemeVersion = DateTime.Now.ToString("yyyyMMddHHmmssffff");
                            _unitWork.Add(modelentity);
                        }
                    }
                    else
                    {
                        modelentity.SchemeVersion = modelentityold.SchemeVersion;
                    }
                    entity.Id = Guid.Parse(keyValue);
                    entity.SchemeVersion = modelentity.SchemeVersion;
                    _unitWork.Update(entity);
                }

               _unitWork.Save();
                return 1;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public void RemoveForm(string keyValue)
        {
            throw new NotImplementedException();
        }

        public WFSchemeInfo GetEntity(string keyValue)
        {
            throw new NotImplementedException();
        }

        public WFSchemeContent GetSchemeEntity(Guid schemeinfoId, string schemeinfoSchemeVersion)
        {
            throw new NotImplementedException();
        }

        public void UpdateState(string keyValue, int state)
        {
            throw new NotImplementedException();
        }

        public List<WFSchemeInfo> GetList()
        {
            return _unitWork.Find<WFSchemeInfo>(null).ToList();
        }
    }
}
