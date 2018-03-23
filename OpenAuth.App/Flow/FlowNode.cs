namespace OpenAuth.App.Flow
{
    /// <summary>
    /// 流程节点
    /// </summary>
    public class FlowNode
    {
        public const string START = "start round mix";
        public const string END = "end round";
        public const string NODE = "node";

        public string id { get; set; }

        public string name { get; set; }

        public string type { get; set; }


        /// <summary>
        /// 节点的附加数据项
        /// </summary>
        /// <value>The set information.</value>
        public Setinfo setInfo { get; set; }

        public FlowNode()
        {
            setInfo = new Setinfo();
        }
    }

    public class Setinfo
    {
        public Nodedesignatedata NodeDesignateData { get; set; }
        public string NodeCode { get; set; }
        public string NodeName { get; set; }

        public Setinfo()
        {
            NodeDesignateData = new Nodedesignatedata();
        }
    }

    /// <summary>
    /// 节点执行人
    /// </summary>
    public class Nodedesignatedata
    {
        public string[] users { get; set; }
        public string[] role { get; set; }
        public string[] org { get; set; }
    }


}
