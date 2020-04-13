namespace OpenAuth.App.Request
{
    public class ChangeProfileReq
    {
        public string Account { get; set; }
       
        /// <summary>
        /// 用户姓名
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 性别
        /// </summary>
        public int Sex { get; set; }
    }
}
