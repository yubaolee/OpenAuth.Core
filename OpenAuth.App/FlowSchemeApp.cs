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
        


        public FlowScheme GetEntity(string keyValue)
        {
            return UnitWork.FindSingle<FlowScheme>(u => u.Id == keyValue);
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
