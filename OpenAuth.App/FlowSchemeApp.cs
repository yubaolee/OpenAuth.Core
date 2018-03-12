using System;
using System.Linq;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    /// <summary>
    /// 流程设计服务
    /// <para>李玉宝新增于2017-01-16 16:18:35</para>
    /// </summary>
    public class FlowSchemeApp :BaseApp<FlowScheme>
    {
        /// <summary>
        /// 保存流程
        /// </summary>
        /// <param name="entity">表单模板实体类</param>
        /// <param name="keyValue">主键</param>
        /// <returns></returns>
        public int SaveForm(string keyValue, FlowScheme entity, FlowSchemeDetail modelentity)
        {
            if (string.IsNullOrEmpty(keyValue))
            {
                entity.SchemeVersion = DateTime.Now.ToString("yyyyMMddHHmmssffff");
                UnitWork.Add(entity);

                modelentity.SchemeId = entity.Id;
                modelentity.SchemeVersion = entity.SchemeVersion;
                UnitWork.Add(modelentity);
            }
            else
            {
                string schemeid = (string)(keyValue);
                FlowSchemeDetail modelentityold =
                    UnitWork.FindSingle<FlowSchemeDetail>(u => u.SchemeVersion == entity.SchemeVersion
                                                                && u.SchemeId == schemeid);

                if (modelentityold.SchemeContent != modelentity.SchemeContent)
                {
                    if (modelentity.SchemeVersion == "cg")
                    {
                        modelentityold.SchemeContent = modelentity.SchemeContent;
                        modelentityold.SchemeVersion = DateTime.Now.ToString("yyyyMMddHHmmssffff");
                        modelentity.SchemeVersion = modelentityold.SchemeVersion;
                        UnitWork.Update(modelentityold);
                    }
                    else
                    {
                        modelentity.SchemeId = schemeid;
                        modelentity.SchemeVersion = DateTime.Now.ToString("yyyyMMddHHmmssffff");
                        UnitWork.Add(modelentity);
                    }
                }
                else
                {
                    modelentity.SchemeVersion = modelentityold.SchemeVersion;
                }
                entity.Id = keyValue;
                entity.SchemeVersion = modelentity.SchemeVersion;
                UnitWork.Update(entity);
            }

            UnitWork.Save();
            return 1;
        }

        public void RemoveForm(string[] keyValue)
        {
             UnitWork.Delete<FlowScheme>(u =>keyValue.Contains(u.Id));
            UnitWork.Delete<FlowSchemeDetail>(u =>keyValue.Contains(u.SchemeId));
        }

        public FlowScheme GetEntity(string keyValue)
        {
            return UnitWork.FindSingle<FlowScheme>(u => u.Id == keyValue);
        }

        public FlowSchemeDetail GetSchemeEntity(string schemeinfoId, string schemeinfoSchemeVersion)
        {
            return UnitWork.FindSingle<FlowSchemeDetail>(u =>
                u.SchemeId == schemeinfoId && u.SchemeVersion == schemeinfoSchemeVersion);
        }

        public void UpdateState(string keyValue, int state)
        {
            throw new NotImplementedException();
        }


        public void Add(FlowScheme flowScheme)
        {
            Repository.Add(flowScheme);
        }

        public void Update(FlowScheme flowScheme)
        {
            UnitWork.Update<FlowScheme>(u => u.Id == flowScheme.Id, u => new FlowScheme
            {
                //todo:要修改的
            });
        }

        public TableData Load(QueryFlowSchemeListReq request)
        {
            return new TableData
            {
                count = Repository.GetCount(null),
                data = Repository.Find(request.page, request.limit, "CreateDate desc")
            };
        }
    }
}
