
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace OpenAuth.Repository
{
   public  class DbExtension
   {
       private OpenAuthDBContext _context;

       public DbExtension(OpenAuthDBContext context)
       {
           _context = context;
       }

       /// <summary>
       /// 获取数据库一个表的所有属性值及属性描述
       /// </summary>
       /// <param name="moduleName">模块名称/表名</param>
       /// <returns></returns>
       public Dictionary<string, string> GetProperties(string moduleName)
       {
           var result = new Dictionary<string,string>();
           var entity = _context.Model.GetEntityTypes().FirstOrDefault(u => u.Name.Contains(moduleName));

           foreach (var property in entity.ClrType.GetProperties())
           {
               object[] objs = property.GetCustomAttributes(typeof(DescriptionAttribute), true);
               var description = objs.Length > 0 ? ((DescriptionAttribute) objs[0]).Description : property.Name;
                result.Add(property.Name, description);
           }

           return result;
       }

        /// <summary>
        /// 获取数据库所有的表名
        /// </summary>
       public List<string> GetTableNames()
       {
           var names = new List<string>();
           var model = _context.Model;

           // Get all the entity types information contained in the DbContext class, ...
           var entityTypes = model.GetEntityTypes();
           foreach (var entityType in entityTypes)
           {
               var tableNameAnnotation = entityType.GetAnnotation("Relational:TableName");
               names.Add(tableNameAnnotation.Value.ToString());

            }
            return names;
       }
   }
}
