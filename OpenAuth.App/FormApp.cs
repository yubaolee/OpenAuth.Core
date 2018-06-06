using System;
using Infrastructure;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;


namespace OpenAuth.App
{
    public class FormApp : BaseApp<Form>
    {
        public RevelanceManagerApp ReleManagerApp { get; set; }

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QueryFormListReq request)
        {

            return new TableData
            {
                count = Repository.GetCount(null),
                data = Repository.Find(request.page, request.limit, "CreateDate desc")
            };
        }

        public void Add(Form obj)
        {
            UnitWork.Add(obj);
            if (!string.IsNullOrEmpty(obj.DbName))
            {
                UnitWork.ExecuteSql(FormUtil.GetSql(obj));
            }
            UnitWork.Save();
        }

        public void Update(Form obj)
        {
            Repository.Update(u => u.Id == obj.Id, u => new Form
            {
                ContentData = obj.ContentData,
                Content = obj.Content,
                ContentParse = obj.ContentParse,
                Name = obj.Name,
                DbName = obj.DbName,
                SortCode = obj.SortCode,
                Description = obj.Description,
                ModifyDate = DateTime.Now
            });

            if (!string.IsNullOrEmpty(obj.DbName))
            {
                UnitWork.ExecuteSql(FormUtil.GetSql(obj));
            }
        }

        public FormResp FindSingle(string id)
        {
            var form = Get(id);
            return form.MapTo<FormResp>();
        }

    }
}