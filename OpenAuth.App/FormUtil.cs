using System.Text;
using Infrastructure;
using Newtonsoft.Json.Linq;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    public class FormUtil {
	
        public static string GetHtml(string contentData, string contentParse,string frmData, string action)
        {
            if (string.IsNullOrEmpty(contentData))
            {
                return string.Empty;
            }
            JObject tableData = null;//表单数据
            if (!string.IsNullOrEmpty(frmData))
            {
               tableData = JsonHelper.Instance.Deserialize<JObject>(frmData);
            }

            string html = contentParse;
            foreach (var json in contentData.ToList<JObject>())
            {
                string name = "";
                string leipiplugins = json.GetValue("leipiplugins").ToString();
                if ("checkboxs" == leipiplugins)
                    name = json.GetValue("parse_name").ToString();
                else
                    name = json.GetValue("name").ToString();

                string tempHtml = "";
                switch (leipiplugins)
                {
                    case "text":
                        tempHtml = GetTextBox(json, tableData, action);
                        break;
                    case "textarea":
                        tempHtml = GetTextArea(json, tableData, action);
                        break;
                    case "radios":
                        tempHtml = GetRadios(json, tableData, action);
                        break;
                    case "select":
                        tempHtml = GetSelect(json, tableData, action);
                        break;
                    case "checkboxs":
                        tempHtml = GetCheckboxs(json, tableData, action);
                        break;

                    case "qrcode"://二维码
                        tempHtml = GetQrcode(json, tableData, action);
                        break;

                    case "progressbar"://进度条 (未做处理)
                        /*temp_html = GetProgressbar(json, tableData, action);*/
                        break;
                    default:
                        tempHtml = json.GetValue("content").ToString();
                        break;
                }

                html = html.Replace("{" + name + "}", tempHtml);
            }


            return html;
        }

        /// <summary>
        /// 只显示编辑框
        /// </summary>
        /// <param name="form">The form.</param>
        /// <returns>System.String.</returns>
        public static string GetHtml(FormResp form){
            if (form.FrmType != 0)  //只有开原版动态表单才需要转换
            {
                return string.Empty;
            }
		
            return GetHtml(form.ContentData, form.ContentParse,null,  "");

        }

        /// <summary>
        /// 显示编辑框和里面的用户数据
        /// </summary>
        /// <param name="contentdata">The contentdata.</param>
        /// <param name="contentParse">The content parse.</param>
        /// <param name="frmData">The FRM data.</param>
        /// <returns>System.String.</returns>
        public static string Preview(FlowInstance flowInstance)
        {
            if (flowInstance.FrmType != 0)  //只有开原版动态表单才需要转换
            {
                return string.Empty;
            }
            
            return GetHtml(flowInstance.FrmContentData, flowInstance.FrmContentParse, 
                flowInstance.FrmData, "view");
        }

        //text
        private static string GetTextBox(JObject item, JObject formData,string action)
        {
            string temp = "<input type=\"text\" value=\"{0}\"  name=\"{1}\"  style=\"{2}\"/>";
            string name = item.GetValue("name").ToString();

            string value =null;
            JToken data;
            if (formData != null && (data = formData.GetValue(name)) != null)
            {
                value = data.ToString();
            }

            if (value == null)
                value = item.GetValue("value") == null ? "" : item.GetValue("value").ToString();
            string style =item.GetValue("style") == null ? "" : item.GetValue("style").ToString();
            string tempHtml =  string.Format(temp, value, name, style);
            if("view"==action)
                return string.Format("<label style=\"{0}\">{1}</label>",style,value);
            return tempHtml;
        }
	
        //TextArea
        private static string GetTextArea(JObject item, JObject formData,string action)
        {
            string script = "";
            if (item.GetValue("orgrich") != null && "1"==item.GetValue("orgrich").ToString())
                script = "orgrich=\"true\" ";
            string name = item.GetValue("name").ToString();

            string value = null;
            JToken data;
            if (formData != null && (data = formData.GetValue(name)) != null)
            {
                value = data.ToString();
            }

            if (value == null)
                value = item.GetValue("value")== null ? "" : item.GetValue("value").ToString();
            string style = item.GetValue("style") == null ? "" : item.GetValue("style").ToString();


            string temp = "<textarea  name=\"{0}\" id=\"{1}\"  style=\"{2}\" {3}>{4}</textarea>";
        
            string temp_html = string.Format(temp, name, name, style, script, value);
        
            if("view"==action)
                return string.Format("<label style=\"{0}\">{1}</label>", style, value);
            return temp_html;
        }
	
        //Radios
        private static string GetRadios(JObject item, JObject formData,string action)
        {
            var radiosOptions = JArray.Parse(item.GetValue("options").ToString());
            //JArray radiosOptions = item["options"] as JArray;
            string temp = "<input type=\"radio\" name=\"{0}\" value=\"{1}\"  {2}>{3}&nbsp;";
            string temp_html = "";
            string name = item.GetValue("name").ToString();

            string value = null;
            JToken data;
            if (formData != null && (data = formData.GetValue(name)) != null)
            {
                value = data.ToString();
            }
            
            foreach (var json in radiosOptions)
            {
                string cvalue = json["value"].ToString();
                string Ischecked = "";

                if (value == null)
                {
                    string check = json["checked"] != null ? json["checked"].ToString() : "";
                    if ("checked" == check || "true" == check)
                    {
                        Ischecked = " checked=\"checked\" ";
                        value = json["value"].ToString();
                    }
                }

                temp_html += string.Format(temp, name, cvalue, Ischecked, cvalue);
            }
		
            return "view"==action ? string.Format("<label style=\"{0}\">{1}</label>", "", value) : temp_html;
        }
	
        //Checkboxs
        private static string GetCheckboxs(JObject item, JObject formData,string action){
            string temp_html = "";
            string temp = "<input type=\"checkbox\" name=\"{0}\" value=\"{1}\" {2}>{3}&nbsp;";
		
            string view_value="";//view 查看值
		
            var checkOptions = JArray.Parse(item.GetValue("options").ToString());
            foreach (var json in checkOptions)
            {
                string name = json["name"].ToString();

                string value = null;
                JToken data;
                if (formData != null && (data = formData.GetValue(name)) != null)
                {
                    value = data.ToString();
                }

                string cvalue = json["value"].ToString();
                string Ischecked = "";
                if (value == null)
                {
                    string check = json["checked"] != null ? json["checked"].ToString() : "";
                    if (check == "checked" || check == "true")
                    {
                        Ischecked = " checked=\"checked\" ";
                        view_value += cvalue + "&nbsp";//view 查看值
                    }
                }
                else if (value != null && value == cvalue)
                {
                    Ischecked = " checked=\"checked\" ";
                    view_value += cvalue + "&nbsp";//view 查看值
                }

                temp_html += string.Format(temp, name, cvalue, Ischecked, cvalue);

            }

            return "view" == action ? string.Format("<label style=\"{0}\">{1}</label>", "", view_value) : temp_html;
        }
	
        //Select(比较特殊)
        private static string GetSelect(JObject item, JObject formData, string action)
        {
            string name = item.GetValue("name").ToString();  //控件的名称
            string value = null;
            JToken data;

            if (formData != null && (data = formData.GetValue(name)) != null)
            {
                value = data.ToString();
            }

            string content =item.GetValue("content").ToString();
            content = content.Replace("leipiNewField", name);
            if (value != null)//用户设置过值
            {
                content = content.Replace("selected=\"selected\"", "");  //先去掉模板中的选中项
                var option = "value=\"" + value + "\"";        //组成选项
                string selected = option + " selected=\"selected\"";  //组成选中项
                content = content.Replace(option, selected);      //把选项替换成选中项
            }

            return "view" == action ? string.Format("<label style=\"{0}\">{1}</label>", "", value) : content;
        }
	
	
        //Qrcode 二维码
        private static string GetQrcode(JObject item, JObject formData, string action)
        {
            string name = item.GetValue("name").ToString();

            string value = null;
            JToken data;
            if (formData != null && (data = formData.GetValue(name)) != null)
            {
                value = data.ToString();
            }

            string temp_html = "";
            string temp = "";
            string orgType = item.GetValue("orgtype").ToString();
            string style = item.GetValue("style").ToString();
            if ("text"==orgType)
            {
                orgType = "文本";
            }
            else if ("url"==orgType)
            {
                orgType = "超链接";
            }
            else if ("tel"==orgType)
            {
                orgType = "电话";
            }
            string qrcode_value = "";
            if (item.GetValue("value")!= null)
                qrcode_value = item.GetValue("value").ToString();
            //print_R($qrcode_value);exit;  //array(value,qrcode_url)
            if ( "edit"==action)
            {
                temp = orgType + "二维码 <input type=\"text\" name=\"{0}\" value=\"{1}\"/>";
                temp_html =  string.Format(temp, name, value);
            }
            else if ("view"==action)
            {
                //可以采用  http://qrcode.leipi.org/ 

                style = "";
                if (item.GetValue("orgwidth") != null)
                {
                    style = "width:" + item.GetValue("orgwidth") + "px;";
                }
                if (item.GetValue("orgheight") != null)
                {
                    style += "height:" + item.GetValue("orgheight") + "px;";
                }
                temp = "<img src=\"{0}\" title=\"{1}\" style=\"{2}\"/>";
                temp_html = string.Format(temp_html, name, value, style);


            }
            else if ( "preview"==action)
            {
                style = "";
                if (item.GetValue("orgwidth")!= null)
                {
                    style = "width:" + item.GetValue("orgwidth") + "px;";
                }
                if (item.GetValue("orgheight")!= null)
                {
                    style += "height:" + item.GetValue("orgheight") + "px;";
                }
                temp = "<img src=\"{0}\" title=\"{1}\" style=\"{2}\"/>";
                temp_html = string.Format(temp_html, name, value, style);
            }

            return temp_html;
        }

        ////Listctrl
        //private static string GetListctrl(JObject item, Dictionary<string,Object> formData, string action)
        //   {
        //       string valuetest = "{\"data_110\":[\"1\",\"2\"],\"data_111\":[\"21\",\"22\",\"22\"]}";

        //       string name = item.GetValue("name").ToString();
        // string value = formData.ContainsKey(name)?formData[name].ToString():null;
        //       string temp_html = "";
        //       string orgSum =item.GetValue("orgsum").ToString();
        //       string orgUnit =item.GetValue("orgunit").ToString();
        //       string orgTitle =item.GetValue("orgtitle").ToString();
        //       string title =item.GetValue("title").ToString();
        //       string style =item.GetValue("style").ToString();
        //       string orgcolvalue =item.GetValue("orgcolvalue").ToString();
        //       string orgcoltype =item.GetValue("orgcoltype").ToString();
        //       List<string> listTitle = Arrays.asList(orgTitle.split("`"));
        //       List<string> listSum = Arrays.asList(orgSum.split("`"));
        //       List<string> listUnit = Arrays.asList(orgUnit.split("`"));
        //       List<string> listValue =Arrays.asList(orgcolvalue.split("`"));
        //       List<string> listType =Arrays.asList(orgcoltype.split("`"));
        //       int tdCount = listTitle.size();


        //       string temp = "<table id=\"" + name + "_table\" bindTable=\"true\" cellspacing=\"0\" class=\"table table-bordered table-condensed\" style=\"" + style + "\"><thead>{0}</thead><tbody>{1}</tbody>{2}</table>";
        //       string btnAdd = "<span class=\"pull-right\"><button class=\"btn btn-small btn-success listAdd\" type=\"button\" tbname=\"" + name + "\">添加一行</button></span>"; //添加按钮
        //       string theader = "<tr><th colspan=\"{0}\">{1}{2}</th></tr>{3}";//头部模版

        //       string trTitle = "";//标题
        //       for (int i = 0; i < tdCount; i++)
        //       {
        //           if (i == tdCount - 1)
        //               listTitle.set(i, "操作");
        //           if ("view"==(action) && i == tdCount - 1) continue;//如果是查看最后一列不显示
        //           	trTitle += string.Format("<th>{0}</th>", listTitle.get(i));
        //       }
        //       trTitle = "<tr>" + trTitle + "</tr>";


        //       JObject dataValue=JObject.fromObject(valuetest);

        //       int rowCount = dataValue != null ? dataValue.size() : 1;


        //       stringBuilder sbTr = new stringBuilder();
        //       string tdSum = "";//如果有统计增加一行
         
         
        //       TreeMap<Integer, Float> SumValueDic = new TreeMap<Integer, Float>();
        //       for (int row = 0; row < rowCount; row++)
        //       {
        	 
        //      	 JSONArray rowValue = (dataValue != null && dataValue.has(name + row)) ? dataValue.getJSONArray(name + row): null;

        //           string tr = "";//默认一行
        //           for (int i = 0; i < tdCount; i++)
        //           {
        //               string tdname = name + "[" + i + "]";
        //               string sum =  "1"==(listSum.get(i)) ? "sum=\"" + tdname + "\"" : "";//是否参与统计
        //               string tdValue =( rowValue != null && rowValue.size() > i) ? rowValue.GetValue(i).ToString(): listValue.get(i);
        //               string type = listType.get(i);//类型

        //               if (sum != "")//一次循环计算该列的值
        //               {
        //                   //region 计算统计值
        //                   float tempTdValue = 0;
        //                   if (SumValueDic.containsKey(i))
        //                       tempTdValue = SumValueDic.get(i);
        //                   try
        //                   {
        //                       float resultTdTemp = 0;
        //                       resultTdTemp=Float.parseFloat(tdValue);
        //                       //float.TryParse(tdValue, out resultTdTemp);
        //                       tempTdValue += resultTdTemp;
        //                   }
        //                   catch (Exception e)
        //                   {
        //                       tdValue = "0";
        //                   }
        //                   if (SumValueDic.containsKey(i))
        //                       SumValueDic.subMap(i,  (int) tempTdValue);
        //                   else
        //                       SumValueDic.put(i, tempTdValue);
        //                   //endregion

        //               }

        //               if (i == tdCount - 1)//最后一列不显示
        //               {
        //                   if ("view"==(action)) continue;
        //                   //tr += "<td></td>";
        //                   else
        //                       tr += "<td><a href=\"javascript:void(0);\" class=\"delrow \">删除</a></td>";
        //                   //tr += string.Format("<td><a href=\"javascript:void(0);\" class=\"delrow {0}\">删除</a></td>", dataValue != null ? "" : "hide");
        //               }
        //               else
        //               {
        //                   if ("view"==(action))
        //                   {
        //                       tr +=  string.Format("<td>{0}</td>", tdValue);
        //                   }
        //                   else
        //                   {
        //                       if ("text"==(type))
        //                           tr +=  string.Format("<td><input class=\"input-medium\" type=\"text\" value=\"{0}\" name=\"{1}[]\" {2}></td>", tdValue, tdname, sum);
        //                       else if ("int"==(type))
        //                           tr +=  string.Format("<td><input class=\"input-medium\" type=\"text\" value=\"{0}\" name=\"{1}[]\" {2}></td>", tdValue, tdname, sum);
        //                       else if ("textarea"==(type))
        //                           tr +=  string.Format("<td><textarea class=\"input-medium\" name=\"{0}\" >{1}</textarea></td>", tdname, tdValue, sum);
        //                       else if ("calc"==(type))
        //                           tr +=  string.Format("<td><input class=\"input-medium\" type=\"text\" value=\"{0}\" name=\"{1}[]\" {2}></td>", tdValue, tdname, sum);
        //                   }
        //               }

        //               if (row == 0)//统计的行只有一行
        //               {
        //                   //region
        //                   if (sum != "")
        //                   {
        //                       if ("view"==(action))
        //                           tdSum +=  string.Format("<td>合计：value{0}{1}</td>", i, listUnit.get(i));
        //                       else
        //                           tdSum +=  string.Format("<td>合计：<input class=\"input-small\" type=\"text\" value=\"value{0}\" name=\"{1}[total]\" {2}\">{3}</td>", i, tdname, sum, listUnit.get(i));
        //                   }
        //                   else
        //                   {
        //                       tdSum += "<td></td>";
        //                   }
        //                   //endregion

        //               }

        //           }
        //           sbTr.append(string.Format("<tr class=\"template\">{0}</tr>", tr) );

        //       }
        //       /*if(!stringUtils.isBlank(tdSum)){
        	 
        //       }*/

        //       if (!stringUtils.isBlank(tdSum)){
        //      	 for (Integer i : SumValueDic.keySet()) {
        //      		 tdSum = tdSum.Replace("value" + i, SumValueDic.get(i).ToString());
        //               tdSum = string.Format("<tbody class=\"sum\"><tr>{0}</tr></tbody>", tdSum);
        //	}
        //       }
        //       if ("view"==(action))
        //           theader = string.Format(theader, tdCount, title, "", trTitle);
        //       else
        //           theader = string.Format(theader, tdCount, title, btnAdd, trTitle);

        //       temp_html = string.Format(temp, theader, sbTr.ToString(), tdSum);
         
        //       return temp_html;
        //   }


	 
	 
	 
        /**
	 * 功能:  创建表单数据表格（基于sql server）
	 */
        public static  string GetSql(Form form){
            // 获取字段并处理
            var jsonArray = JArray.Parse(form.ContentData);
		
            // 数据库名称
            string tableName= form.DbName ;
            // 创建数据表
            StringBuilder sql =new StringBuilder("if exists ( select * from sysobjects where name = '"
                +tableName+"' and type = 'U') drop table " 
                + tableName +";") ;  

            sql.Append("CREATE TABLE "
                       + tableName
                       + " (   [Id] varchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,"); //主键

            string sqlDefault = "";

            foreach (var json in jsonArray)
            {
                string name;
                string type = json["leipiplugins"].ToString();

                if ("checkboxs" == type)
                    name = json["parse_name"].ToString();
                else
                    name = json["name"].ToString();

                sql.Append("[" + name + "] " + field_type_sql(type));//字段拼接


                if ("checkboxs" == type)
                    sqlDefault += field_type_sql_default(tableName, name, "0");
                else
                    sqlDefault += field_type_sql_default(tableName, name, "''");
            }

            sql.Append(");");

            //设置主键
            sql.Append("ALTER TABLE "+tableName+" ADD CONSTRAINT [PK_"+form.DbName+"] PRIMARY KEY NONCLUSTERED ([Id])");
            sql.Append(
                "WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ");
            sql.Append("ON [PRIMARY];");

            //主键默认值
            sql.Append("ALTER TABLE "+tableName+" ADD   DEFAULT (newid()) FOR [Id];");

            return sql+sqlDefault;

        }
        //获取控件字段类型 的sql 
        private static string field_type_sql(string leipiplugins)
        {
            if ("textarea"==leipiplugins || "listctrl"==leipiplugins)
            {
                return " text  NULL ,";
            }
            else if ("checkboxs"==leipiplugins)
            {
                return " int NOT NULL ,";
            }
            else
            {
                return " varchar(255)  NULL ,";
            }
        }
        private static string field_type_sql_default(string tablename, string field, string defaultValue)
        {
            return "ALTER TABLE "+tablename+" ADD  DEFAULT ("+defaultValue+") FOR ["+field+"];";
        }
    }
}
