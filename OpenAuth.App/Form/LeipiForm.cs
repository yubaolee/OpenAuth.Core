using System.Text;
using Infrastructure;
using Newtonsoft.Json.Linq;

namespace OpenAuth.App
{
    public class LeipiForm : IForm
    {
        /**
	 * 功能:  创建表单数据表格（基于sql server）
	 */
        public string GetSql(Repository.Domain.Form form, string dbType)
        {
            if (dbType == Define.DBTYPE_SQLSERVER) //Sql Server
            {
                // 获取字段并处理
                var jsonArray = JArray.Parse(form.ContentData);

                // 数据库名称
                string tableName = form.DbName;
                // 创建数据表
                StringBuilder sql = new StringBuilder("if exists ( select * from sysobjects where name = '"
                                                      + tableName + "' and type = 'U') drop table "
                                                      + tableName + ";");

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

                    sql.Append("[" + name + "] " + field_type_sql(type)); //字段拼接


                    if ("checkboxs" == type)
                        sqlDefault += field_type_sql_default(tableName, name, "0");
                    else
                        sqlDefault += field_type_sql_default(tableName, name, "''");
                }

                sql.Append(");");

                //设置主键
                sql.Append("ALTER TABLE " + tableName + " ADD CONSTRAINT [PK_" + form.DbName +
                           "] PRIMARY KEY NONCLUSTERED ([Id])");
                sql.Append(
                    "WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ");
                sql.Append("ON [PRIMARY];");

                //主键默认值
                sql.Append("ALTER TABLE " + tableName + " ADD   DEFAULT (newid()) FOR [Id];");

                return sql + sqlDefault;
            }
            else
            {
                // 获取字段并处理
                var jsonArray = JArray.Parse(form.ContentData);

                // 数据库名称
                string tableName = form.DbName;
                // 创建数据表
                StringBuilder sql = new StringBuilder("create table if not exists `"
                                                      + tableName
                                                      + "` (   Id varchar(50) not null primary key,"); //主键

                foreach (var json in jsonArray)
                {
                    string name;
                    string type = json["leipiplugins"].ToString();

                    if ("checkboxs" == type)
                        name = json["parse_name"].ToString();
                    else
                        name = json["name"].ToString();

                    sql.Append("`" + name + "` " + field_type_mysql(type)); //字段拼接

//
//                    if ("checkboxs" == type)
//                        sqlDefault += field_type_sql_default(tableName, name, "0");
//                    else
//                        sqlDefault += field_type_sql_default(tableName, name, "''");
                }

                sql.Append(");");

                return sql.ToString();
            }
        }

        private string field_type_sql(string leipiplugins)
        {
            if ("textarea" == leipiplugins || "listctrl" == leipiplugins)
            {
                return " text  NULL ,";
            }
            else if ("checkboxs" == leipiplugins)
            {
                return " int NOT NULL ,";
            }
            else
            {
                return " varchar(255)  NULL ,";
            }
        }

        private string field_type_mysql(string leipiplugins)
        {
            if ("textarea" == leipiplugins || "listctrl" == leipiplugins)
            {
                return " varchar(255) null ,";
            }
            else if ("checkboxs" == leipiplugins)
            {
                return " tinyint not null ,";
            }
            else
            {
                return " varchar(255)  NULL ,";
            }
        }

        private string field_type_sql_default(string tablename, string field, string defaultValue)
        {
            return "ALTER TABLE " + tablename + " ADD  DEFAULT (" + defaultValue + ") FOR [" + field + "];";
        }
    }
}