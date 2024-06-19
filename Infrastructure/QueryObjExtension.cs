using System.Linq;
using System.Text;

namespace Infrastructure;

/// <summary>
/// 查询对象FilterGroup扩展，将对象转换为sql查询
/// </summary>
public static class QueryObjExtension
{
    /// <summary>
    /// 根据过滤器组构建查询。
    /// </summary>
    public static string BuildQuery(this QueryObject query)
    {
        StringBuilder sb = new StringBuilder();
        BuildQuery(query, sb);
        return sb.ToString();
    }

    /// <summary>
    /// 递归构建查询字符串。
    /// </summary>
    private static void BuildQuery(QueryObject query, StringBuilder sb)
    {
        // 构建当前过滤器组的过滤条件
        if (query.Filters != null && query.Filters.Length > 0)
        {
            string filters = string.Join($" {query.Operation} ", query.Filters.Select(f => $"{f.Key} {f.Contrast} '{f.Value}'"));
            sb.Append($"({filters})");
        }

        // 构建当前过滤器组的子过滤器组
        if (query.Children != null && query.Children.Length > 0)
        {
            // 如果当前字符串不为空，则添加操作符连接子过滤器组
            if (sb.Length > 0)
            {
                sb.Append($" {query.Operation} ");
            }
            // 使用递归方式构建子过滤器组的查询字符串，并连接到当前字符串
            string children = string.Join($" {query.Operation} ", query.Children.Select(child =>
            {
                StringBuilder childSb = new StringBuilder();
                BuildQuery(child, childSb);
                return childSb.ToString();
            }));
            sb.Append($"({children})");
        }
    }
}
