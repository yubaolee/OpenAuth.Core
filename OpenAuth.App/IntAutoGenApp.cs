using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 主键为numberic类型的业务，使用BaseLongApp基类
    /// </summary>
    public class IntAutoGenApp :BaseIntAutoGenApp<IntAutoGen, OpenAuthDBContext>
    {
        public void Add(IntAutoGen application)
        {
            Repository.Add(application);
        }

        public void Update(IntAutoGen application)
        {
            Repository.Update(application);
        }


        public async Task<List<IntAutoGen>> GetList(QueryAppListReq request)
        {
            var applications =  UnitWork.Find<IntAutoGen>(null) ;
           
            return applications.ToList();
        }

        public IntAutoGenApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<IntAutoGen,OpenAuthDBContext> repository,IAuth auth) 
            : base(unitWork, repository, auth)
        {
        }
    }
}