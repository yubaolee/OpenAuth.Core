namespace OpenAuth.App.Request
{
    /// <summary>
    /// 为角色分配数据字段权限
    /// </summary>
    public class AssignDataReq
    {
        /// <summary>
        /// 角色ID
        /// </summary>
        public string RoleId { get; set; }
        /// <summary>
        /// 模块的Code,比如Category/Resource
        /// </summary>
        public string ModuleCode { get; set; }
        /// <summary>
        /// 字段名称列表
        /// </summary>
        public string[] Properties { get; set; }
    }
}