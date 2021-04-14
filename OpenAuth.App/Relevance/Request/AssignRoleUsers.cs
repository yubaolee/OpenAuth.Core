namespace OpenAuth.App.Request
{
    /// <summary>
    /// 角色分配用户
    /// </summary>
    public class AssignRoleUsers
    {
        /// <summary>
        /// 角色id
        /// </summary>
        public string RoleId { get; set; }
        /// <summary>
        /// 用户id列表
        /// </summary>
        public string[] UserIds { get; set; }
    }
}