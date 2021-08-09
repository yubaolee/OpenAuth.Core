using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using Autofac.Extensions.DependencyInjection;
using Infrastructure;
using Infrastructure.Utilities;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Internal;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.QueryObj;

namespace OpenAuth.App
{
    public class DbExtension
    {
        private List<DbContext> _contexts = new List<DbContext>();
        
        private IOptions<AppSetting> _appConfiguration;
        private IHttpContextAccessor _httpContextAccessor;

        public DbExtension(IOptions<AppSetting> appConfiguration, OpenAuthDBContext openAuthDbContext, IHttpContextAccessor httpContextAccessor)
        {
            _appConfiguration = appConfiguration;
            _httpContextAccessor = httpContextAccessor;
            _contexts.Add(openAuthDbContext);  //如果有多个DBContext，可以按OpenAuthDBContext同样的方式添加到_contexts中
        }

        /// <summary>
        /// 获取数据库一个表的所有属性值及属性描述
        /// </summary>
        /// <param name="moduleName">模块名称/表名</param>
        /// <returns></returns>
        public List<KeyDescription> GetProperties(string moduleName)
        {
            var result = new List<KeyDescription>();
            const string domain = "openauth.repository.domain.";
            IEntityType entity = null; 
            _contexts.ForEach(u =>
            {
                entity = u.Model.GetEntityTypes()
                    .FirstOrDefault(u => u.Name.ToLower() == domain + moduleName.ToLower());
            });
            if (entity == null)
            {
                throw new Exception($"未能找到{moduleName}对应的实体类");
            }

            foreach (var property in entity.ClrType.GetProperties())
            {
                object[] objs = property.GetCustomAttributes(typeof(DescriptionAttribute), true);
                object[] browsableObjs = property.GetCustomAttributes(typeof(BrowsableAttribute), true);
                var description = objs.Length > 0 ? ((DescriptionAttribute) objs[0]).Description : property.Name;
                if (string.IsNullOrEmpty(description)) description = property.Name;
                //如果没有BrowsableAttribute或 [Browsable(true)]表示可见，其他均为不可见，需要前端配合显示
                bool browsable = browsableObjs == null || browsableObjs.Length == 0 ||
                                 ((BrowsableAttribute) browsableObjs[0]).Browsable;
                var typeName = property.PropertyType.Name;
                if (Nullable.GetUnderlyingType(property.PropertyType) != null)
                {
                    typeName = Nullable.GetUnderlyingType(property.PropertyType).Name;
                }
                result.Add(new KeyDescription
                {
                    Key = property.Name,
                    Description = description,
                    Browsable = browsable,
                    Type = typeName
                });
            }

            return result;
        }

        /// <summary>
        /// 获取数据库DbContext中所有的实体名称。
        /// <para>注意！并不能获取数据库中的所有表</para>
        /// </summary>
        public List<string> GetDbEntityNames()
        {
            var names = new List<string>();
            var models = _contexts.Select(u =>u.Model);

            foreach (var model in models)
            {
                // Get all the entity types information contained in the DbContext class, ...
                var entityTypes = model.GetEntityTypes();
                foreach (var entityType in entityTypes)
                {
                    var tableNameAnnotation = entityType.GetAnnotation("Relational:TableName");
                    names.Add(tableNameAnnotation.Value.ToString());
                }
            }

            return names;
        }

        /// <summary>
        /// 获取数据库表结构信息
        /// </summary>
        /// <param name="tableName"></param>
        /// <returns></returns>
        public IList<SysTableColumn> GetDbTableStructure(string tableName)
        {
            var dbtype = _appConfiguration.Value.DbTypes[_httpContextAccessor.GetTenantId()];
            if (dbtype == Define.DBTYPE_MYSQL)
            {
                return GetMySqlStructure(tableName);
            }
            else if (dbtype == Define.DBTYPE_SQLSERVER)
            {
                return GetSqlServerStructure(tableName);
            }
            else
            {
                return GetOracleStructure(tableName);
            }
        }

        /// <summary>
        /// 获取Oracle表结构
        /// </summary>
        private IList<SysTableColumn> GetOracleStructure(string tableName)
        {
            var sql = $@"
select utc.column_name as                           COLUMNNAME,
       utc.data_type                                COLUMNTYPE,
       utc.data_length                              MaxLength,
       CASE utc.nullable WHEN 'N' THEN 0 ELSE 1 END IsNull,
       utc.data_default                             DEFAULTVAL,
       ucc.comments                                 ""COMMENT"",
            UTC.table_name                               TABLENAME,
                CASE UTC.COLUMN_NAME
                WHEN (select col.column_name
                from user_constraints con,
                user_cons_columns col
                where con.constraint_name = col.constraint_name
            and con.constraint_type = 'P'
            and col.table_name = '{ tableName}') THEN 1
            ELSE 0 END  AS                           IsKey,
                CASE
            WHEN data_type IN ('BIT', 'BOOL') THEN
            'bool'
            WHEN data_type in ('SMALLINT') THEN 'short'
            WHEN data_type in ('TINYINT') THEN 'bool'
            WHEN data_type IN ('NUMBER', 'CHAR', 'INT', 'Year') THEN
            'int'
            WHEN data_type in ('BIGINT') THEN
            'bigint'
            WHEN data_type IN ('FLOAT', 'DOUBLE', 'DECIMAL') THEN
            'decimal'
            WHEN data_type IN
            ('CHAR', 'VARCHAR', 'TINY TEXT', 'TEXT', 'MEDIUMTEXT', 'LONGTEXT', 'TINYBLOB', 'BLOB',
                'MEDIUMBLOB', 'LONGBLOB', 'Time') THEN
            'string'
            WHEN data_type IN ('Date', 'DateTime', 'TIMESTAMP(6)') THEN
            'DateTime'
            ELSE 'string'
            END         AS                           EntityType
                from user_tab_columns utc,
                user_col_comments ucc
                where utc.table_name = ucc.table_name
            and utc.column_name = ucc.column_name
            and utc.table_name = '{ tableName}'
            order by column_id; ";
            
            foreach (var context in _contexts)
            {
                var columns = context.Query<SysTableColumn>().FromSqlRaw(sql);
                var columnList = columns?.ToList();
                if (columnList != null && columnList.Any())
                {
                    return columnList;
                }
            }
            
            return new List<SysTableColumn>();
        }

        /// <summary>
        /// 获取Mysql表结构信息
        /// </summary>
        private IList<SysTableColumn> GetMySqlStructure(string tableName)
        {
            var sql =  $@"SELECT  DISTINCT
                    Column_Name AS ColumnName,
                     '{ tableName}'  as tableName,
	                Column_Comment AS Comment,
                    data_type as ColumnType,
                        CASE
                          WHEN data_type IN( 'BIT', 'BOOL', 'bit', 'bool') THEN
                'bool'
		             WHEN data_type in('smallint','SMALLINT') THEN 'short'
								WHEN data_type in('tinyint','TINYINT') THEN 'bool'
                        WHEN data_type IN('MEDIUMINT','mediumint', 'int','INT','year', 'Year') THEN
                    'int'
                    WHEN data_type in ( 'BIGINT','bigint') THEN
                    'bigint'
                    WHEN data_type IN('FLOAT', 'DOUBLE', 'DECIMAL','float', 'double', 'decimal') THEN
                    'decimal'
                    WHEN data_type IN('CHAR', 'VARCHAR', 'TINY TEXT', 'TEXT', 'MEDIUMTEXT', 'LONGTEXT', 'TINYBLOB', 'BLOB', 'MEDIUMBLOB', 'LONGBLOB', 'Time','char', 'varchar', 'tiny text', 'text', 'mediumtext', 'longtext', 'tinyblob', 'blob', 'mediumblob', 'longblob', 'time') THEN
                    'string'
                    WHEN data_type IN('Date', 'DateTime', 'TimeStamp','date', 'datetime', 'timestamp') THEN
                    'DateTime' ELSE 'string'
                END AS EntityType,
	              case WHEN CHARACTER_MAXIMUM_LENGTH>8000 THEN 0 ELSE CHARACTER_MAXIMUM_LENGTH end  AS Maxlength,
            CASE
                    WHEN COLUMN_KEY = 'PRI' THEN  
                    1 ELSE 0
                END AS IsKey,
            CASE
                    WHEN Column_Name IN( 'CreateID', 'ModifyID', '' ) 
		            OR COLUMN_KEY<> '' THEN
                        0 ELSE 1
                        END AS IsDisplay,
		            1 AS IsColumnData,
                    120 AS ColumnWidth,
                    0 AS OrderNo,
                CASE
                        WHEN IS_NULLABLE = 'NO' THEN
                        0 ELSE 1
                    END AS IsNull,
	            CASE
                        WHEN COLUMN_KEY <> '' THEN
                        1 ELSE 0
                    END AS IsReadDataset
                FROM
                    information_schema.COLUMNS
                WHERE
                    table_name = '{tableName}'";

            foreach (var context in _contexts)
            {
                var columns = context.Query<SysTableColumn>().FromSqlRaw(sql);
                var columnList = columns?.ToList();
                if (columnList != null && columnList.Any())
                {
                    return columnList;
                }
            }
            
            return new List<SysTableColumn>();
            
        }
       
        
         /// <summary>
        /// 获取SqlServer表结构信息
        /// </summary>
        /// <param name="tableName"></param>
        /// <returns></returns>
        private IList<SysTableColumn> GetSqlServerStructure(string tableName)
        {
            var sql =  $@"
            SELECT TableName,
                LTRIM(RTRIM(ColumnName)) AS ColumnName,
                Comment,
                CASE WHEN ColumnType = 'uniqueidentifier' THEN 'guid'
                     WHEN ColumnType IN('smallint', 'INT') THEN 'int'
                     WHEN ColumnType = 'BIGINT' THEN 'long'
                     WHEN ColumnType IN('CHAR', 'VARCHAR', 'NVARCHAR',
                                          'text', 'xml', 'varbinary', 'image')
                     THEN 'string'
                     WHEN ColumnType IN('tinyint')
                     THEN 'byte'
                     WHEN ColumnType IN('bit')
                     THEN 'bool'

                     WHEN ColumnType IN('bit') THEN 'bool'
                     WHEN ColumnType IN('time', 'date', 'DATETIME', 'smallDATETIME')
                     THEN 'DateTime'
                     WHEN ColumnType IN('smallmoney', 'DECIMAL', 'numeric',
                                          'money') THEN 'decimal'
                     WHEN ColumnType = 'float' THEN 'float'
                     ELSE 'string'
                END as  EntityType,
                    ColumnType,
                    [Maxlength],
                IsKey,
                CASE WHEN ColumnName IN('CreateID', 'ModifyID', '')
                          OR IsKey = 1 THEN 0
                     ELSE 1
                END AS IsDisplay ,
				1 AS IsColumnData,

              CASE   
                     WHEN ColumnName IN('Modifier', 'Creator') THEN 130
                     WHEN[Maxlength] < 110 AND[Maxlength] > 60 THEN 120
                     WHEN[Maxlength] < 200 AND[Maxlength] >= 110 THEN 180
                     WHEN[Maxlength] > 200 THEN 220
                     ELSE 90
                   END AS ColumnWidth ,
                0 AS OrderNo,
                --CASE WHEN IsKey = 1 OR t.[IsNull]=0 THEN 0
                --     ELSE 1 END
                t.[IsNull] AS
                 [IsNull],
            CASE WHEN IsKey = 1 THEN 1 ELSE 0 END IsReadDataset,
            CASE WHEN IsKey!=1 AND t.[IsNull] = 0 THEN 0 ELSE NULL END AS EditColNo
        FROM    (SELECT obj.name AS TableName ,
                            col.name AS ColumnName ,
                            CONVERT(NVARCHAR(100),ISNULL(ep.[value], '')) AS Comment,
                            t.name AS ColumnType ,
                           CASE WHEN  col.length<1 THEN 0 ELSE  col.length END  AS[Maxlength],
                            CASE WHEN EXISTS (SELECT   1
                                               FROM dbo.sysindexes si
                                                        INNER JOIN dbo.sysindexkeys sik ON si.id = sik.id
                                                              AND si.indid = sik.indid
                                                        INNER JOIN dbo.syscolumns sc ON sc.id = sik.id
                                                              AND sc.colid = sik.colid
                                                        INNER JOIN dbo.sysobjects so ON so.name = si.name
                                                              AND so.xtype = 'PK'
                                               WHERE sc.id = col.id
                                                        AND sc.colid = col.colid)
                                 THEN 1
                                 ELSE 0
                            END AS IsKey ,
                            CASE WHEN col.isnullable = 1 THEN 1
                                 ELSE 0
                            END AS[IsNull],
                            col.colorder
                  FROM      dbo.syscolumns col
                            LEFT JOIN dbo.systypes t ON col.xtype = t.xusertype
                           INNER JOIN dbo.sysobjects obj ON col.id = obj.id

                                                            AND obj.xtype IN ( 'U','V')
                                                          --   AND obj.status >= 01
                            LEFT JOIN dbo.syscomments comm ON col.cdefault = comm.id
                            LEFT JOIN sys.extended_properties ep ON col.id = ep.major_id
                                                              AND col.colid = ep.minor_id
                                                              AND ep.name = 'MS_Description'
                            LEFT JOIN sys.extended_properties epTwo ON obj.id = epTwo.major_id
                                                              AND epTwo.minor_id = 0
                                                              AND epTwo.name = 'MS_Description'
                  WHERE obj.name =  '{ tableName}') AS t
            ORDER BY t.colorder";

            foreach (var context in _contexts)
            {
                var columns = context.Query<SysTableColumn>().FromSqlRaw(sql);
                var columnList = columns?.ToList();
                if (columnList != null && columnList.Any())
                {
                    return columnList;
                }
            }
            return new List<SysTableColumn>();
        }
    }
}