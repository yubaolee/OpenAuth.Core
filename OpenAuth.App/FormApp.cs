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
                data = Repository.Find(request.page, request.limit,"CreateDate desc")
            };
        }

        public void Add(Form obj)
        {
            UnitWork.Add(obj);
            UnitWork.ExecuteSql(FormUtil.GetSql(obj));
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
               DbName = obj.DbName
            });

            Repository.ExecuteSql(FormUtil.GetSql(obj));
        }

        public Form FindSingle(string id)
        {
            return Repository.FindSingle(u => u.Id == id);
        }

    }
}