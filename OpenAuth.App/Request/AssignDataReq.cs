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
        /// 模块id
        /// </summary>
        public string ModuleId { get; set; }
        /// <summary>
        /// 字段名称列表
        /// </summary>
        public string[] Properties { get; set; }
    }
}