using System;
using System.Collections.Generic;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Domain.Service
{
    public class WorkflowService
    {
        protected IUnitWork _unitWork;

        public WorkflowService(IUnitWork unitWork)
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

                    modelentity.WFSchemeInfoId = entity.Id.ToString();
                    modelentity.SchemeVersion = entity.SchemeVersion;
                    _unitWork.Add(modelentity);
                }
                else
                {
                    WFSchemeContent modelentityold =
                        _unitWork.FindSingle<WFSchemeContent>(u => u.SchemeVersion == entity.SchemeVersion
                                                                   && u.WFSchemeInfoId == keyValue); 

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
                            modelentity.WFSchemeInfoId = keyValue;
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
            throw new NotImplementedException();
        }
    }
}
