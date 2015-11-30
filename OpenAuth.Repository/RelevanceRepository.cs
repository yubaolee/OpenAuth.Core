using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Repository
{
    public class RelevanceRepository :BaseRepository<Relevance>, IRelevanceRepository
    {
      
        public void DeleteBy(string key,params int[] firstIds)
        {
            Delete(u => firstIds.Contains(u.FirstId) && u.Key == key);
        }

        public void AddRelevance(string key, Dictionary<int, int> ids)
        {
            foreach (var roleid in ids)
            {
                Add(new Relevance
                {
                    Key = key,
                    FirstId = roleid.Key,
                    SecondId = roleid.Value,
                    OperateTime = DateTime.Now
                });
            }
            Save();
        }
    }
}
