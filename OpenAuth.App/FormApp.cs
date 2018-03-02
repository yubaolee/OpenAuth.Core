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
            Repository.Add(obj);
        }
        
        public void Update(Form obj)
        {
            UnitWork.Update<Form>(u => u.Id == obj.Id, u => new Form
            {
               //todo:要修改的
            });

        }

        public Form FindSingle(string id)
        {
            return Repository.FindSingle(u => u.Id == id);
        }

    }
}