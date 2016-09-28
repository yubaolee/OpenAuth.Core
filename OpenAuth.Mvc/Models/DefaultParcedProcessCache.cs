using System;
using System.Collections.Generic;
using OptimaJet.Workflow.Core.Cache;
using OptimaJet.Workflow.Core.Model;

namespace OpenAuth.Mvc.Models
{
    /// <summary>
    /// 流程定义的缓存
    /// <para>李玉宝新增于2016-09-28 17:15:45</para>
    /// </summary>
    public sealed class DefaultParcedProcessCache : IParsedProcessCache
    {
        private Dictionary<Guid, ProcessDefinition> _cache;

        public void Clear()
        {
            _cache.Clear();
        }

        public ProcessDefinition GetProcessDefinitionBySchemeId(Guid schemeId)
        {
            if (_cache == null)
                return null;
            if (_cache.ContainsKey(schemeId))
                return _cache[schemeId];
            return null;
        }

        public void AddProcessDefinition(Guid schemeId, ProcessDefinition processDefinition)
        {
            if (_cache == null)
            {
                _cache = new Dictionary<Guid, ProcessDefinition> {{schemeId, processDefinition}};
            }
            else
            {
                if (_cache.ContainsKey(schemeId))
                    _cache[schemeId] = processDefinition;
                else
                    _cache.Add(schemeId, processDefinition);
            }
        }
    }
}
