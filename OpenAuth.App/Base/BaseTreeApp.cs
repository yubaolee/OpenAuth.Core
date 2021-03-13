using System.Linq;
using Microsoft.EntityFrameworkCore;
using OpenAuth.App.Interface;
using OpenAuth.Repository.Core;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    /// <summary>
    /// 树状结构处理
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class BaseTreeApp<T,TDbContext> :BaseStringApp<T,TDbContext> where T : TreeEntity where TDbContext :DbContext
    {


        public BaseTreeApp(IUnitWork<TDbContext> unitWork, IRepository<T, TDbContext> repository, IAuth auth) 
            : base(unitWork, repository,auth)
        {
        }

       
        /// <summary>
        /// 更新树状结构实体
        /// </summary>
        /// <param name="obj"></param>
        /// <typeparam name="U"></typeparam>
        public void UpdateTreeObj<U>(U obj) where U : TreeEntity
        {
            CaculateCascade(obj);

            //获取旧的的CascadeId
            var cascadeId = Repository.FirstOrDefault(o => o.Id == obj.Id).CascadeId;
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