
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;

using OpenAuth.App.ViewModel;

namespace OpenAuth.App
{
    public class RevelanceManagerApp
    {

        private readonly IRelevanceRepository _relevanceRepository;

        public RevelanceManagerApp(IRelevanceRepository relevanceRepository)
        {
            _relevanceRepository = relevanceRepository;
        }

        /// <summary>
        /// 添加关联
        /// <para>比如给用户分配资源，那么firstId就是用户ID，secIds就是资源ID列表</para>
        /// </summary>
        /// <param name="type">关联的类型，如"UserResource"</param>
        public void Assign(string type, Guid firstId, Guid[] secIds)
        {
            _relevanceRepository.AddRelevance(type, secIds.ToLookup(u => firstId));
        }

        /// <summary>
        /// 取消关联
        /// </summary>
        /// <param name="type">关联的类型，如"UserResource"</param>
        /// <param name="firstId">The first identifier.</param>
        /// <param name="secIds">The sec ids.</param>
        public void UnAssign(string type, Guid firstId, Guid[] secIds)
        {
            _relevanceRepository.DeleteBy(type, secIds.ToLookup(u =>firstId));
        }
    }
}