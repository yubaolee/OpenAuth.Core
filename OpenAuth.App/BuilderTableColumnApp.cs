using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class BuilderTableColumnApp : BaseStringApp<BuilderTableColumn,OpenAuthDBContext>
    {
        public BuilderTableColumnApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<BuilderTableColumn,OpenAuthDBContext> repository,
            IAuth auth) : base(unitWork, repository,auth)
        {
        }

        /// <summary>
        /// 加载列表
        /// </summary>
        public async Task<TableResp<BuilderTableColumn>> Load(QueryBuilderTableColumnListReq request)
        {
            if (string.IsNullOrEmpty(request.BuilderTableId))
            {
                throw new Exception($"缺少必要的参数BuilderTableId");
            }
            var result = new TableResp<BuilderTableColumn>();
            var objs = UnitWork.Find<BuilderTableColumn>(u =>u.TableId == request.BuilderTableId);
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.ColumnName.Contains(request.key));
            }

            result.data = objs.OrderBy(u => u.ColumnName)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).ToList();
            result.count = objs.Count();
            return result;
        }

        public void Update(AddOrUpdateBuilderTableColumnReq obj)
        {
            var user = _auth.GetCurrentUser().User;
            UnitWork.Update<BuilderTableColumn>(u => u.Id == obj.Id, u => new BuilderTableColumn
            {
                TableId = obj.TableId,
                TableName = obj.TableName,
                ColumnName = obj.ColumnName,
                Comment = obj.Comment,
                ColumnType = obj.ColumnType,
                EntityType = obj.EntityType,
                EntityName = obj.EntityName,
                IsKey = obj.IsKey,
                IsIncrement = obj.IsIncrement,
                IsRequired = obj.IsRequired,
                IsInsert = obj.IsInsert,
                IsEdit = obj.IsEdit,
                IsList = obj.IsList,
                IsQuery = obj.IsQuery,
                QueryType = obj.QueryType,
                HtmlType = obj.HtmlType,
                EditType = obj.EditType,
                Sort = obj.Sort,
                CreateTime = obj.CreateTime,
                CreateUserId = obj.CreateUserId,
                EditRow = obj.EditRow,
                EditCol = obj.EditCol,
                CreateUserName = obj.CreateUserName,
                MaxLength = obj.MaxLength,
                DataSource = obj.DataSource,
                UpdateTime = DateTime.Now,
                UpdateUserId = user.Id,
                UpdateUserName = user.Name
                //todo:补充或调整自己需要的字段
            });

        }
            

       

        public List<BuilderTableColumn> Find(string tableId)
        {
            return Repository.Find(u => u.TableId == tableId).ToList();
        }
    }
}