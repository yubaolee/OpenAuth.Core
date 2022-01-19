namespace OpenAuth.Repository.QueryObj
{
    /// <summary>
    /// 针对只返回字符串类型的数值。查询SQL必需使用Value作为返回字段
    /// 因为string没有构造函数，不能作为DbSet/DbQuery泛型的参数
    /// </summary>
    public class QueryStringObj
    {
        public string Value { get; set; }
    }
}