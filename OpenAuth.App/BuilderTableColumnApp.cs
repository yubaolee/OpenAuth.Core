using System;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class BuilderTableColumnApp : BaseApp<BuilderTableColumn>
    {
        private RevelanceManagerApp _revelanceApp;

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QueryBuilderTableColumnListReq request)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            var properties = loginContext.GetProperties("BuilderTableColumn");

            if (properties == null || properties.Count == 0)
            {
                throw new Exception("当前登录用户没有访问该模块字段的权限，请联系管理员配置");
            }


            var result = new TableData();
            var objs = UnitWork.Find<BuilderTableColumn>(null);
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.Id.Contains(request.key));
            }


            var propertyStr = string.Join(',', properties.Select(u => u.Key));
            result.columnHeaders = properties;
            result.data = objs.OrderBy(u => u.Id)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).Select($"new ({propertyStr})");
            result.count = objs.Count();
            return result;
        }

        public void Add(AddOrUpdateBuilderTableColumnReq req)
        {
            var obj = req.MapTo<BuilderTableColumn>();
            //todo:补充或调整自己需要的字段
            obj.CreateTime = DateTime.Now;
            var user = _auth.GetCurrentUser().User;
            obj.CreateUserId = user.Id;
            obj.CreateUserName = user.Name;
            Repository.Add(obj);
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
                UpdateTime = DateTime.Now,
                EditRow = obj.EditRow,
                EditCol = obj.EditCol,
                CreateUserName = obj.CreateUserName,
                UpdateUserId = user.Id,
                UpdateUserName = user.Name
                //todo:补充或调整自己需要的字段
            });

        }
            

        public BuilderTableColumnApp(IUnitWork unitWork, IRepository<BuilderTableColumn> repository,
            RevelanceManagerApp app, IAuth auth) : base(unitWork, repository,auth)
        {
            _revelanceApp = app;
        }
    }
}