using System;
using System.Collections.Generic;

namespace Infrastructure
{
    public class ControlHelper
    {
        /// <summary>
        /// 根据集合得到下拉框
        /// </summary>
        /// <typeparam name="T">实体对象</typeparam>
        /// <param name="rList">实体集合</param>
        /// <param name="id">下拉框的id</param>
        /// <param name="valFiled">值 字段名</param>
        /// <param name="nameFiled">文本 字段名</param>
        /// <param name="selected">需要选中的值</param>
        /// <param name="css">样式名称</param>
        /// <returns></returns>
        public static string GetDropDownByList<T>(List<T> rList, string id, string valFiled, string nameFiled, string selected = "0", string css = "")
        {
            string str = " <select id='" + id + "' name='" + id + "' class='" + css + "'>";
            foreach (var item in rList)
            {
                string value = item.GetType().GetProperty(valFiled).GetValue(item, null).ToString();
                string text = item.GetType().GetProperty(nameFiled).GetValue(item, null).ToString();
                str += "<option ";
                if (value.Equals(selected)) str += " selected='selected' ";
                str += " value='" + value + "'>" + text + "</option>";
            }
            if (rList.Count == 0) str += "<option value='没有数据'>没有数据</option>";
            str += " </select>";
            return str;
        }

        /// <summary>
        /// 根据枚举得到下拉框
        /// </summary>
        /// <typeparam name="type">枚举对象</typeparam>
        /// <param name="id">下拉框的id</param>
        /// <param name="selected">需要选中的值</param>
        /// <param name="css">样式名称</param>
        /// <returns></returns>
        public static string GetDropDownByEnum(Type type, string id, string selected = "", string css = "")
        {
            string str = " <select id='" + id + "' name='" + id + "' class='" + css + "'>";
            str += "<option value=''>全部</option>";
            foreach (int item in System.Enum.GetValues(type))
            {
                string value = item.ToString();
                string text = System.Enum.GetName(type, item);
                str += "<option ";
                if (value.Equals(selected)) str += " selected='selected' ";
                str += " value='" + value + "'>" + text + "</option>";
            }
            str += " </select>";
            return str;
        }
    }
}
