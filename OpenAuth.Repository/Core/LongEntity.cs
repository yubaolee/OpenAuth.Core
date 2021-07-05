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
        public decimal Id { get; set; }
        public override bool KeyIsNull()
        {
            return Id == 0;
        }
        
        static LongEntity()
        {
            //设置参数，程序初始化时执行一次
            var options = new IdGeneratorOptions()
            {
                Method = 1,
                WorkerId = 1
            };
            
            YitIdHelper.SetIdGenerator(options);
        }

        /// <summary>
        /// 采用雪花算法计算Id
        /// </summary>
        public override void GenerateDefaultKeyVal()
        {
            Id = YitIdHelper.NextId();
        }
    }
}