using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 流程设计服务
    /// <para>李玉宝新增于2017-01-16 16:18:35</para>
    /// </summary>
    public class WFSchemeService
    {
        public IUnitWork _unitWork { get; set; }

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
                    string schemeid = (string)(keyValue);
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
                    entity.Id = keyValue;
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

        public void RemoveForm(string[] keyValue)
        {
             _unitWork.Delete<WFSchemeInfo>(u =>keyValue.Contains(u.Id));
            _unitWork.Delete<WFSchemeContent>(u =>keyValue.Contains(u.SchemeInfoId));
        }

        public WFSchemeInfo GetEntity(string keyValue)
        {
            return _unitWork.FindSingle<WFSchemeInfo>(u => u.Id == keyValue);
        }

        public WFSchemeContent GetSchemeEntity(string schemeinfoId, string schemeinfoSchemeVersion)
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

        public TableData Load(int pageCurrent, int pageSize)
        {
            var result = new TableData();

            result.count = _unitWork.Find<WFSchemeInfo>(null).Count();
            result.data = _unitWork.Find<WFSchemeInfo>(pageCurrent, pageSize, "ModifyDate descending", null).ToList();

            return result;
        }
    }
}
