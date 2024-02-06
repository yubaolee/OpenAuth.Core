namespace OpenAuth.Repository.QueryObj
{
    /// <summary>
    /// 系统表列信息
    /// </summary>
     public class SysTableColumn 
    {
        /// <summary>
        /// 列名
        /// </summary>
        public string ColumnName { get; set; }
        /// <summary>
        /// 列注释
        /// </summary>
        public string Comment { get; set; }
        /// <summary>
        /// 类型，已转为.net类型
        /// </summary>
        public string ColumnType { get; set; }
        /// <summary>
        /// 最大长度
        /// </summary>
        public int? MaxLength { get; set; }
        /// <summary>
        /// 是否可空
        /// </summary>
        public int? IsNull { get; set; }
        /// <summary>
        /// 是否显示
        /// </summary>
        public int? IsDisplay { get; set; }
        /// <summary>
        /// 是否主键
        /// </summary>
        public int? IsKey { get; set; }
        public string EntityType { get; set; }
    }
}