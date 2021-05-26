namespace OpenAuth.App.Request
{
    public class QuerySysMessageListReq : PageReq
    {
        /// <summary>
        /// 消息状态 0:未读；1：已读； 999:全部
        /// </summary>
        public int Status { get; set; }
    }
}