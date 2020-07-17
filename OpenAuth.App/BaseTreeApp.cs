using System.Linq;
using OpenAuth.App.Interface;
using OpenAuth.Repository.Core;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 业务层基类，UnitWork用于事务操作，Repository用于普通的数据库操作
    /// <para>如用户管理：Class UserManagerApp:BaseApp<User></para>
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class BaseTreeApp<T> :BaseApp<T> where T : TreeEntity
    {


        public BaseTreeApp(IUnitWork unitWork, IRepository<T> repository, IAuth auth) 
            : base(unitWork, repository,auth)
        {
        }

       
        public void UpdateTreeObj<U>(U obj) where U : TreeEntity
        {
            CaculateCascade(obj);

            //获取旧的的CascadeId
            var cascadeId = Repository.FindSingle(o => o.Id == obj.Id).CascadeId;
            //根据CascadeId查询子部门
            var objs = Repository.Find(u => u.CascadeId.Contains(cascadeId) && u.Id != obj.Id)
                .OrderBy(u => u.CascadeId).ToList();

            //更新操作
            UnitWork.Update(obj);

            //更新子模块的CascadeId
            foreach (var a in objs)
            {
                a.CascadeId = a.CascadeId.Replace(cascadeId, obj.CascadeId);
                if (a.ParentId == obj.Id)
                {
                    a.ParentName = obj.Name;
                }

                UnitWork.Update(a);
            }

            UnitWork.Save();
        }

       
    }
}