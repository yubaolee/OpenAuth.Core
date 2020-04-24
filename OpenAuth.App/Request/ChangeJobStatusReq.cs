namespace OpenAuth.App.Request
{
    public class ChangeJobStatusReq
    {
        /// <summary>
        /// 任务ID
        /// </summary>
        public string Id { get; set; }
        
        /// <summary>
        /// 改变任务状态
        /// 0：停止；1：启动（任务变成正在运行）
        /// </summary>
        public int Status { get; set; }
    }
}
