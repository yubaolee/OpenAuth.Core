using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using CodeSmith.Engine;
using SchemaExplorer;

namespace Util{
   public class Tools{
       public static String GetDescription(ColumnSchema column) {  //得到字段的描述
            if(string.IsNullOrEmpty(column.Description)) 
                return column.Name; 
            else 
                return column.Description;
        }

        public static bool NeedCascade(TableSchema SourceTable){  //判断表中是否需要下拉选择树
          return   SourceTable.Columns.Contains("ParentId") 
                ||  SourceTable.Columns.Contains("CascadeId") ;
        }
   } 
}