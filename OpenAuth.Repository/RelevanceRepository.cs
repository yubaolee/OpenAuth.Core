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