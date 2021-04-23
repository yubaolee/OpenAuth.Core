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
        public const string FORK = "fork"; //会签开始节点
        public const string JOIN = "join"; //会签结束节点

        public string id { get; set; }

        public string name { get; set; }

        public string type { get; set; }

        public int left { get; set; }
        public int top { get; set; }

        public int width { get; set; }
        public int height { get; set; }
        public bool alt { get; set; }

        /// <summary>
        /// 节点的附加数据项
        /// </summary>
        /// <value>The set information.</value>
        public Setinfo setInfo { get; set; }
    }

    public class Setinfo
    {
        public const string ALL_USER = "ALL_USER"; //所有用户
        public const string SPECIAL_ROLE = "SPECIAL_ROLE"; //指定角色
        public const string SPECIAL_USER = "SPECIAL_USER"; //指定用户

        public const string RUNTIME_SPECIAL_ROLE = "RUNTIME_SPECIAL_ROLE"; //运行时指定角色
        public const string RUNTIME_SPECIAL_USER = "RUNTIME_SPECIAL_USER"; //运行时指定用户

        /// <summary>
        /// 节点执行权限类型
        /// </summary>
        public string NodeDesignate { get; set; }

        public Nodedesignatedata NodeDesignateData { get; set; }
        public string NodeCode { get; set; }
        public string NodeName { get; set; }

        /// <summary>
        ///  流程执行时，三方回调的URL地址
        /// </summary>
        public string ThirdPartyUrl { get; set; }

        /// <summary>
        /// 驳回节点0"前一步"1"第一步"2"某一步" 3"不处理"
        /// </summary>
        public string NodeRejectType { get; set; }

        public int? Taged { get; set; }
        public string UserName { get; set; }
        public string UserId { get; set; }
        public string Description { get; set; }
        public string TagedTime { get; set; }

        //节点会签方式，
        //all/空：默认为全部通过
        //one ：至少有一个通过
        public string NodeConfluenceType { get; set; }

        /// <summary>
        /// 会签通过的个数
        /// </summary>
        public int? ConfluenceOk { get; set; }

        /// <summary>
        /// 会签拒绝的个数
        /// </summary>
        public int? ConfluenceNo { get; set; }
    }

    /// <summary>
    /// 节点执行人
    /// </summary>
    public class Nodedesignatedata
    {
        public string[] users { get; set; }
        public string[] roles { get; set; }
        public string[] orgs { get; set; }
    }

    /// <summary>
    /// 节点执行结果标签
    /// </summary>
    public class Tag
    {
        /// <summary>
        ///  1: 通过
        ///  2：不通过
        ///  3：驳回
        /// </summary>
        public int Taged { get; set; }

        public string UserId { get; set; }
        public string UserName { get; set; }
        public string Description { get; set; }
        public string TagedTime { get; set; }
    }

    /// <summary>
    ///  1: 通过
    ///  2：不通过
    ///  3：驳回
    /// </summary>
    public enum TagState
    {
        Ok = 1,
        No,
        Reject
    }
}