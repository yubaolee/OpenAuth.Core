using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Linq;

namespace OpenAuth.Repository
{
    public class RelevanceRepository : BaseRepository<Relevance>, IRelevanceRepository
    {
        public void DeleteBy(string key, params int[] firstIds)
        {
            Delete(u => firstIds.Contains(u.FirstId) && u.Key == key);
        }

        /// <summary>
        /// 删除关联
        /// </summary>
        /// <param name="key">关联标识</param>
        /// <param name="idMaps">关联的&lt;firstId, secondId&gt;数组</param>
        public void DeleteBy(string key, ILookup<int, int> idMaps)
        {
            foreach (var sameVals in idMaps)
            {
                foreach (var value in sameVals)
                {
                    Delete(u =>u.Key == key && u.FirstId == sameVals.Key && u.SecondId == value);
                }
            }
        }

        /// <summary>
        /// 添加新的关联
        /// </summary>
        /// <param name="key">关联标识</param>
        /// <param name="idMaps">关联的&lt;firstId, secondId&gt;数组</param>
        public void AddRelevance(string key, ILookup<int, int> idMaps)
        {
            foreach (var sameVals in idMaps)
            {
                foreach (var value in sameVals)
                {
                    Add(new Relevance
                     {
                         Key = key,
                         FirstId = sameVals.Key,
                         SecondId = value,
                         OperateTime = DateTime.Now
                     });
                }
            }
            Save();
        }
    }
}