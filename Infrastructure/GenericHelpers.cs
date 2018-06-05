using System;
using System.Collections.Generic;
using System.Linq;

namespace Infrastructure
{
    /// <summary>
    /// List转成Tree
    /// <para>李玉宝新增于2016-10-09 19:54:07</para>
    /// </summary>
    public static class GenericHelpers
    {
        /// <summary>
        /// Generates tree of items from item list
        /// </summary>
        /// 
        /// <typeparam name="T">Type of item in collection</typeparam>
        /// <typeparam name="K">Type of parent_id</typeparam>
        /// 
        /// <param name="collection">Collection of items</param>
        /// <param name="idSelector">Function extracting item's id</param>
        /// <param name="parentIdSelector">Function extracting item's parent_id</param>
        /// <param name="rootId">Root element id</param>
        /// 
        /// <returns>Tree of items</returns>
        public static IEnumerable<TreeItem<T>> GenerateTree<T, K>(
            this IEnumerable<T> collection,
            Func<T, K> idSelector,
            Func<T, K> parentIdSelector,
            K rootId = default(K))
        {
            foreach (var c in collection.Where(u =>
            {
                var selector = parentIdSelector(u);
                return (rootId == null && selector == null)  
                || (rootId != null &&rootId.Equals(selector));
            }))
            {
                yield return new TreeItem<T>
                {
                    Item = c,
                    Children = collection.GenerateTree(idSelector, parentIdSelector, idSelector(c))
                };
            }
        }
        /// <summary>
        /// 把数组转为逗号连接的字符串
        /// </summary>
        /// <param name="data"></param>
        /// <param name="Str"></param>
        /// <returns></returns>
        public static string ArrayToString(dynamic data, string Str)
        {
            string resStr = Str;
            foreach (var item in data)
            {
                if (resStr != "")
                {
                    resStr += ",";
                }

                if (item is string)
                {
                    resStr += item;
                }
                else
                {
                    resStr += item.Value;

                }
            }
            return resStr;
        }
    }
}