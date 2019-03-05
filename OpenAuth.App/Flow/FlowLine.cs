using Newtonsoft.Json.Linq;

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

        /// <summary> 分支条件 </summary>
        public DataCompare compare { get; set; }

        public bool Compare(JObject frmDataJson)
        {
            switch (this.compare.Operation)
            {
                case "==":
                    return compare.Value == frmDataJson.GetValue(compare.FieldName).ToString();
                default:
                    return true;
            }
        }
    }

    /// <summary>
    ///  分支条件
    /// </summary>
    public class DataCompare
    {
        public const string Larger = ">";
        public const string Less = "<";
        public const string LargerEqual = ">=";
        public const string LessEqual = "<=";
        public const string NotEqual = "!=";
        public const string Equal = "==";

        /// <summary>操作类型比如大于/等于/小于</summary>
        /// <value> The operation. </value>
        public string Operation { get; set; }

        /// <summary> form种的字段名称 </summary>
        public string FieldName { get; set; }

        /// <summary>比较的值</summary>
        public string Value { get; set; }
    }
}
