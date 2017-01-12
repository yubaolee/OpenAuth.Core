using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LeaRun.Util.WebControl
{
    /// <summary>
    /// 表头属性模型
    /// </summary>
    public class GridColumnModel
    {
        /// <summary>
        /// 定义表格单元格（非表头）的对齐方式，可取值：left, center, right
        /// </summary>
        public string align { get; set; }
        /// <summary>
        /// 此属性用于定义列的类名，当有多个类名时，用空格间隔，例如：“class1 class2”。在表格的CSS中，有一个预定义的类ui-ellipsis用于定义特定的行
        /// </summary>
        public string classes { get; set; }
        /// <summary>
        /// 日期格式，可用/，-和.。作为间隔符。y、Y、yyyy用于4位年，YY、yy用于2位的月，d、dd用于日期
        /// </summary>
        public string datefmt { get; set; }
        /// <summary>
        /// 搜索字段的缺省值，此参数只用于自定义搜索是的初始值。
        /// </summary>
        public string defval { get; set; }
        /// <summary>
        /// 定义字段是否可编辑，用于单元格编辑、行编辑和表单模式
        /// </summary>
        public bool editable { get; set; }
        /// <summary>
        /// 根据edittype 参数定义可用的值数组
        /// </summary>
        public string[] editoptions { get; set; }
        /// <summary>
        /// 设置可编辑字段的补充规则
        /// </summary>
        public string[] editrules { get; set; }
        /// <summary>
        /// 定义行编辑和表单模式的编辑类型，可以是text、textarea、select、checkbox、 password、button、image和file。
        /// </summary>
        public string edittype { get; set; }
        /// <summary>
        /// 定义表单编辑的各种选项
        /// </summary>
        public string[] formoptions { get; set; }
        /// <summary>
        /// 定义初始化时，列是否隐藏。
        /// </summary>
        public string hidden { get; set; }
        /// <summary>
        /// 通过sidx参数设置排序时的索引名。
        /// </summary>
        public string index { get; set; }
        /// <summary>
        /// 当colNames数组为空时，定义此列的标题。若colNames数组和此属性都为空，标题为该列的name属性值。
        /// </summary>
        public string label { get; set; }
        /// <summary>
        /// 设置列在表格中的唯一名称，此属性是必须的。或者使用保留字subgrid、cb和rn.
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// 定义是否可变列宽
        /// </summary>
        public bool resizable { get; set; }
        /// <summary>
        /// 定义是否可以排序
        /// </summary>
        public string sortable { get; set; }
        /// <summary>
        /// 当datatype为local时，用于定义排序列类型。可取int/integer（整数）、float/number/currency（小数）、date（日期）、text（文本）
        /// </summary>
        public string sorttype { get; set; }
        /// <summary>
        /// 当设置为false时，鼠标滑向单元格时不显示title属性
        /// </summary>
        public bool title { get; set; }
        /// <summary>
        /// 设置列的初始宽度，可用pixels和百分比
        /// </summary>
        public int width { get; set; }
        /// <summary>
        /// 自定义格式化
        /// </summary>
        public string formatter { get; set; }
        /// <summary>
        /// 排序码
        /// </summary>
        public int? SortCode { get; set; }
        /// <summary>
        /// 有效
        /// </summary>
        public int? Enabled { get; set; }
    }
}
