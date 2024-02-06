using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Infrastructure;
using Microsoft.EntityFrameworkCore;
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
        
        private DbExtension _dbExtension;
        public BuilderTableColumnApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<BuilderTableColumn,OpenAuthDBContext> repository,
            IAuth auth, DbExtension dbExtension) : base(unitWork, repository,auth)
        {
            _dbExtension = dbExtension;
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

            result.data =await objs.OrderByDescending(u => u.IsList)
                .ThenBy(u=>u.Sort)
                .ThenBy(u =>u.ColumnName)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).ToListAsync();
            result.count =await objs.CountAsync();
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
        
        /// <summary>
        /// 同步数据结构
        /// <para>读取数据库结构与当前结构的差异，如果数据库有新增的字段，则自动加入</para>
        /// </summary>
        public void Sync(SyncStructureReq req)
        {
            var columns = _dbExtension.GetDbTableStructure(req.TableName);
            if (!columns.Any())
            {
                throw new Exception($"未能找到{req.TableName}表结构定义");
            }

            var exists = Find(req.Id).Select(u=>u.ColumnName);

            foreach (var column in columns)
            {
                if(exists.Contains(column.ColumnName)) continue;
                var builderColumn = new BuilderTableColumn
                {
                    ColumnName = column.ColumnName,
                    Comment = column.Comment,
                    ColumnType = column.ColumnType,
                    EntityType = column.EntityType,
                    EntityName = column.ColumnName,

                    IsKey = column.IsKey == 1,
                    IsRequired = column.IsNull != 1,
                    IsEdit = true,
                    IsInsert = true,
                    IsList = true,
                    MaxLength = column.MaxLength,
                    TableName = req.TableName,
                    TableId = req.Id,
                    
                    CreateTime = DateTime.Now
                };
                UnitWork.Add(builderColumn);
            }
            UnitWork.Save();
        }

            

       

        public List<BuilderTableColumn> Find(string tableId)
        {
            return Repository.Find(u => u.TableId == tableId).ToList();
        }
    }
}