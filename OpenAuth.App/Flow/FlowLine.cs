namespace OpenAuth.App.Flow
{
    /// <summary>
    /// 流程连线
    /// </summary>
    public class FlowLine
    {
        public string id { get; set; }
        public string type { get; set; }
        public string from { get; set; }
        public string to { get; set; }
        public string name { get; set; }
        public bool dash { get; set; }
    }
}
