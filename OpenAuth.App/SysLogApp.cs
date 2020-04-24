using System.Linq;
using System.Reflection;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class SysLogApp : BaseApp<SysLog>
    {

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QuerySysLogListReq request)
        {
            var result = new TableData();
            var objs = UnitWork.Find<SysLog>(null);
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.Content.Contains(request.key) || u.Id.Contains(request.key));
            }

            result.data = objs.OrderByDescending(u => u.CreateTime)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit);
            result.count = objs.Count();
            return result;
        }

        public void Add(SysLog obj)
        {
            //程序类型取入口应用的名称，可以根据自己需要调整
            obj.Application = Assembly.GetEntryAssembly().FullName.Split(',')[0];
            Repository.Add(obj);
        }
        
        public void Update(SysLog obj)
        {
            UnitWork.Update<SysLog>(u => u.Id == obj.Id, u => new SysLog
            {
               //todo:要修改的字段赋值
            });

        }

        public SysLogApp(IUnitWork unitWork, IRepository<SysLog> repository) : base(unitWork, repository, null)
        {
        }
    }
}