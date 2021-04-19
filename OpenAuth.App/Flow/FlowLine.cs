// <copyright file="FlowLine.cs" company="openauth.me">
// Copyright (c) 2019 openauth.me. All rights reserved.
// </copyright>
// <author>www.cnblogs.com/yubaolee</author>
// <date>2019-03-05</date>
// <summary>流程中的连线</summary>

using System.Collections.Generic;
using Infrastructure.Extensions;
using Newtonsoft.Json.Linq;

namespace OpenAuth.App.Flow
{
    /// <summary>
    /// 流程连线
    /// </summary>
    public class FlowLine
    {
        public string id { get; set; }
        public string label { get; set; }
        public string type { get; set; }
        public string from { get; set; }
        public string to { get; set; }
        public string name { get; set; }
        public bool dash { get; set; }

        /// <summary> 分支条件 </summary>
        public List<DataCompare> Compares { get; set; }

        public bool Compare(JObject frmDataJson)
        {
            bool result = true;
            foreach (var compare in Compares)
            {

                bool isDecimal = decimal.TryParse(compare.Value, out decimal value);
                var fieldVal = frmDataJson.GetValue(compare.FieldName.ToLower()).ToString();

                if (isDecimal)  //如果是数字或小数
                {
                    decimal frmvalue = decimal.Parse(fieldVal); //表单中填写的值

                    switch (compare.Operation)
                    {
                        case DataCompare.Equal:
                            result &= compare.Value == fieldVal;
                            break;
                        case DataCompare.Larger:
                            result &= frmvalue > value;
                            break;
                        case DataCompare.Less:
                            result &= frmvalue < value;
                            break;
                        case DataCompare.LargerEqual:
                            result &= frmvalue >= value;
                            break;
                        case DataCompare.LessEqual:
                            result &= frmvalue <= value;
                            break;
                    }
                }
                else //如果只是字符串，只判断相等
                {
                    result &= compare.Value == fieldVal;
                }

                
            }

            return result;
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
        public const string Equal = "=";

        /// <summary>操作类型比如大于/等于/小于</summary>
        public string Operation { get; set; }

        /// <summary> form种的字段名称 </summary>
        public string FieldName { get; set; }

        /// <summary> 字段类型："form"：为表单中的字段，后期扩展系统表等. </summary>
        public string FieldType { get; set; }

        /// <summary>比较的值</summary>
        public string Value { get; set; }
    }
}
