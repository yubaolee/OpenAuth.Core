using System.ComponentModel;
using Yitter.IdGenerator;

namespace OpenAuth.Repository.Core
{
    /// <summary>
    /// 数据库Id为numberic类型的数据实体使用该基类，用法同Entity
    /// 数据库Id字段为numberic(16,0)或以上长度的整型，采用雪花算法生成Id。
    /// </summary>
    public class LongEntity :BaseEntity
    {
        [Browsable(false)]
        public long Id { get; set; }
        public override bool KeyIsNull()
        {
            return Id == 0;
        }

        /// <summary>
        /// 采用雪花算法计算Id
        /// </summary>
        public override void GenerateDefaultKeyVal()
        {
            // 全局初始化设置WorkerId，默认最大2^16-1。（初始化过程全局只需一次，且必须最先设置）
            var options = new IdGeneratorOptions(){ WorkerId = 1};
            IIdGenerator IdHelper = new YitIdGenerator(options);
            
            // 初始化以后，就可以在需要的地方调用方法生成ID。
            Id =  IdHelper.NewLong();
        }
    }
}