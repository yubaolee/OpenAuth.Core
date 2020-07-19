using System;
using System.ComponentModel;

namespace OpenAuth.Repository.Core
{
    /// <summary>
    /// 主键为字符串的实体基类，为系统默认的实体类型
    /// </summary>
    public class Entity : BaseEntity
    {
        [Browsable(false)]
        public string Id { get; set; }
        
        /// <summary>
        /// 判断主键是否为空，常用做判定操作是【添加】还是【编辑】
        /// </summary>
        /// <returns></returns>
        public override bool KeyIsNull()
        {
            return string.IsNullOrEmpty(Id);
        }

        /// <summary>
        /// 创建默认的主键值
        /// </summary>
        public override void GenerateDefaultKeyVal()
        {
            Id = Guid.NewGuid().ToString();
        }
    }
}
