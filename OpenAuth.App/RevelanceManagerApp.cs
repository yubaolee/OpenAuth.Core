using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.App
{
    public class RevelanceManagerApp
    {

          public IUnitWork _unitWork { get; set; }

        /// <summary>
        /// 添加关联
        /// <para>比如给用户分配资源，那么firstId就是用户ID，secIds就是资源ID列表</para>
        /// </summary>
        /// <param name="type">关联的类型，如"UserResource"</param>
        public void Assign(string type, string firstId, string[] secIds)
        {
            Assign(type, secIds.ToLookup(u => firstId));
        }

        public void Assign(string key, ILookup<string, string> idMaps)
        {
            DeleteBy(key, idMaps);
            _unitWork.BatchAdd((from sameVals in idMaps
                from value in sameVals
                select new Relevance
                {
                    Key = key,
                    FirstId = sameVals.Key,
                    SecondId = value,
                    OperateTime = DateTime.Now
                }).ToArray());
            _unitWork.Save();
        }

      

        /// <summary>
        /// 删除关联
        /// </summary>
        /// <param name="key">关联标识</param>
        /// <param name="idMaps">关联的&lt;firstId, secondId&gt;数组</param>
        public void DeleteBy(string key, ILookup<string, string> idMaps)
        {
            foreach (var sameVals in idMaps)
            {
                foreach (var value in sameVals)
                {
                    _unitWork.Delete<Relevance>(u => u.Key == key && u.FirstId == sameVals.Key && u.SecondId == value);
                }
            }
        }

        /// <summary>
        /// 取消关联
        /// </summary>
        /// <param name="type">关联的类型，如"UserResource"</param>
        /// <param name="firstId">The first identifier.</param>
        /// <param name="secIds">The sec ids.</param>
        public void UnAssign(string type, string firstId, string[] secIds)
        {
            DeleteBy(type, secIds.ToLookup(u =>firstId));
        }

        public void DeleteBy(string key, params string[] firstIds)
        {
            _unitWork.Delete<Relevance>(u => firstIds.Contains(u.FirstId) && u.Key == key);
        }

        /// <summary>
        /// 添加新的关联
        /// </summary>
        /// <param name="key">关联标识</param>
        /// <param name="idMaps">关联的&lt;firstId, secondId&gt;数组</param>
        public void AddRelevance(string key, ILookup<string, string> idMaps)
        {
            DeleteBy(key, idMaps);
            _unitWork.BatchAdd<Relevance>((from sameVals in idMaps
                from value in sameVals
                select new Relevance
                {
                    Key = key,
                    FirstId = sameVals.Key,
                    SecondId = value,
                    OperateTime = DateTime.Now
                }).ToArray());
            _unitWork.Save();
        }

        /// <summary>
        /// 根据关联表的一个键获取另外键的值
        /// </summary>
        /// <param name="key">映射标识</param>
        /// <param name="returnSecondIds">返回的是否为映射表的第二列，如果不是则返回第一列</param>
        /// <param name="ids">已知的ID列表</param>
        /// <returns>List&lt;System.String&gt;.</returns>
        public List<string> Get(string key, bool returnSecondIds, params string[] ids)
        {
            if (returnSecondIds)
            {
                return _unitWork.Find<Relevance>(u => u.Key == key
                                                      && ids.Contains(u.FirstId)).Select(u => u.SecondId).ToList();
            }
            else
            {
                return _unitWork.Find<Relevance>(u => u.Key == key
                     && ids.Contains(u.SecondId)).Select(u => u.FirstId).ToList();
            }
        }
    }
}