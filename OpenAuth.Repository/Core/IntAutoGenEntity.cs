using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace OpenAuth.Repository.Core
{
    /// <summary>
    /// 数据库Id为numberic且为数据库自动生成的数据实体使用该基类，用法同Entity
    /// <para>该场景通常为SqlServer的自动增长类型和Oracle自带的Sequence</para>
    /// </summary>
    public class IntAutoGenEntity :BaseEntity
    {
        [Browsable(false)]
        [Key,DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public override bool KeyIsNull()
        {
            return Id == 0;
        }

        public override void GenerateDefaultKeyVal()
        {
            //主键自动增长类型，可以不用该方法生成主键，设置该方法为空方法即可
            //当DbContext执行SaveChanges()后，如果添加成功，可以直接获取对象的Id
        }
    }
}