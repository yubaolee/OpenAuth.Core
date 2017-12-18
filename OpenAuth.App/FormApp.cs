using System.Linq;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;


namespace OpenAuth.App
{
    public class FormApp : BaseApp<WFFrmMain>
    {
        public RevelanceManagerApp ReleManagerApp { get; set; }

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QueryFormListReq request)
        {
            var forms = UnitWork.Find<WFFrmMain>(null)
                   .OrderBy(u => u.FrmCode)
                   .Skip((request.page - 1) * request.limit)
                   .Take(request.limit);


            return new TableData
            {
                count = Repository.GetCount(null),
                data = forms,
            };
        }

        public void Add(WFFrmMain obj)
        {
            Repository.Add(obj);
        }
        
        public void Update(WFFrmMain obj)
        {
            UnitWork.Update<WFFrmMain>(u => u.Id == obj.Id, u => new WFFrmMain
            {
                FrmCode = obj.FrmCode,
                FrmContent = obj.FrmContent
            });

        }

    }
}