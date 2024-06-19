namespace Infrastructure
{
   
    /// <summary>
    /// 查询表达式中的最小单元，如：
    /// new Filter {Key = "name", Value = "yubaolee", Contrast = "=="},
    /// new Filter {Key = "name", Value = "yubaolee", Contrast = "contains"},
    /// new Filter {Key = "age", Value = "10,20,30", Contrast = "in"},
    /// new Filter {Key = "10,20,30", Value = "40", Contrast = "intersect"}
    /// </summary>
    public class Filter
    {
        /// <summary>
        /// 过滤条件的关键字。
        /// </summary>
        public string Key { get; set; }
        
        /// <summary>
        /// 通常为值，如：yubaolee、10、10,20,30等。
        /// </summary>
        public string Value { get; set; }
        
        /// <summary>
        /// 通常为运算符，如：==、contains、in、intersect等。
        /// </summary>
        public string Contrast { get; set; }
        
        /// <summary>
        /// 对于特殊值的说明
        /// </summary>
        public string Text { get; set; }
    }

    /// <summary>
    /// 查询对象类，用于封装查询条件。
    /// </summary>
    public class QueryObject 
    {
        /// <summary>
        /// 操作类型，定义了查询条件之间的逻辑关系，如OR、AND。
        /// </summary>
        /// <remarks>
        /// 该属性决定了如何组合多个过滤条件，以构建复杂的查询逻辑。
        /// </remarks>
        public string Operation { get; set; }
        
        /// <summary>
        /// 过滤器数组，包含一组过滤条件。
        /// </summary>
        public Filter[] Filters { get; set; }
        
        /// <summary>
        /// 子查询对象数组，支持嵌套查询。
        /// </summary>
        /// <remarks>
        /// 通过嵌套查询对象，可以构建复杂的查询逻辑，处理更复杂的数据关系。
        /// </remarks>
        public QueryObject[] Children { get; set; }
    }

    
    
    
}