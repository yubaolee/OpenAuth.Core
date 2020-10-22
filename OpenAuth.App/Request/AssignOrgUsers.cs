namespace OpenAuth.App.Request
{
    /// <summary>
    /// 部门分配用户
    /// </summary>
    public class AssignOrgUsers
    {
        /// <summary>
        /// 部门id
        /// </summary>
        public string OrgId { get; set; }
        /// <summary>
        /// 用户id列表
        /// </summary>
        public string[] UserIds { get; set; }
    }
}