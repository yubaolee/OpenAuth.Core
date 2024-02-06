using System.Collections.Generic;

namespace OpenAuth.App.Request
{
    public class NodeDesignateReq
    {
        /// <summary>
        /// 如果下个执行节点是运行时指定执行者。需要传指定的类型
        /// <para>取值为RUNTIME_SPECIAL_ROLE、RUNTIME_SPECIAL_USER</para>
        /// </summary>
        public string NodeDesignateType { get; set; }
        
        /// <summary>
        /// 如果下个执行节点是运行时指定执行者。该值表示具体的执行者
        /// <para>如果NodeDesignateType为RUNTIME_SPECIAL_ROLE，则该值为指定的角色</para>
        /// <para>如果NodeDesignateType为RUNTIME_SPECIAL_USER，则该值为指定的用户</para>
        /// </summary>
        public string[] NodeDesignates { get; set; }
    }
}
