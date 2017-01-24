using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.App
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

        public void RemoveForm(Guid[] keyValue)
        {
             _unitWork.Delete<WFSchemeInfo>(u =>keyValue.Contains(u.Id));
            _unitWork.Delete<WFSchemeContent>(u =>keyValue.Contains(u.SchemeInfoId));
        }

        public WFSchemeInfo GetEntity(Guid keyValue)
        {
            return _unitWork.FindSingle<WFSchemeInfo>(u => u.Id == keyValue);
        }

        public WFSchemeContent GetSchemeEntity(Guid schemeinfoId, string schemeinfoSchemeVersion)
        {
            return _unitWork.FindSingle<WFSchemeContent>(u =>
                u.SchemeInfoId == schemeinfoId && u.SchemeVersion == schemeinfoSchemeVersion);
        }

        public void UpdateState(string keyValue, int state)
        {
            throw new NotImplementedException();
        }

        public List<WFSchemeInfo> GetList()
        {
            return _unitWork.Find<WFSchemeInfo>(null).ToList();
        }

        public GridData Load(int pageCurrent, int pageSize)
        {
            var result = new GridData
            {
                page = pageCurrent
            };

            int cnt = _unitWork.Find<WFSchemeInfo>(null).Count();
            result.total = cnt%pageSize  ==0?cnt/pageSize:cnt/pageSize+1;
            result.rows = _unitWork.Find<WFSchemeInfo>(pageCurrent, pageSize, "ModifyDate descending", null).ToList();

            return result;
        }
    }
}
