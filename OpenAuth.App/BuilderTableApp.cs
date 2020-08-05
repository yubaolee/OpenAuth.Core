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
    public class BuilderTableApp : BaseApp<BuilderTable>
    {
        private RevelanceManagerApp _revelanceApp;

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QueryBuilderTableListReq request)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            var properties = loginContext.GetProperties("BuilderTable");

            if (properties == null || properties.Count == 0)
            {
                throw new Exception("当前登录用户没有访问该模块字段的权限，请联系管理员配置");
            }


            var result = new TableData();
            var objs = UnitWork.Find<BuilderTable>(null);
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

        public void Add(AddOrUpdateBuilderTableReq req)
        {
            var obj = req.MapTo<BuilderTable>();
            //todo:补充或调整自己需要的字段
            obj.CreateTime = DateTime.Now;
            var user = _auth.GetCurrentUser().User;
            obj.CreateUserId = user.Id;
            obj.CreateUserName = user.Name;
            Repository.Add(obj);
        }

         public void Update(AddOrUpdateBuilderTableReq obj)
        {
            var user = _auth.GetCurrentUser().User;
            UnitWork.Update<BuilderTable>(u => u.Id == obj.Id, u => new BuilderTable
            {
                TableName = obj.TableName,
                Comment = obj.Comment,
                DetailTableName = obj.DetailTableName,
                DetailComment = obj.DetailComment,
                ClassName = obj.ClassName,
                Namespace = obj.Namespace,
                ModuleCode = obj.ModuleCode,
                ModuleName = obj.ModuleName,
                Folder = obj.Folder,
                Options = obj.Options,
                TypeId = obj.TypeId,
                TypeName = obj.TypeName,
                CreateTime = obj.CreateTime,
                CreateUserId = obj.CreateUserId,
                CreateUserName = obj.CreateUserName,
                UpdateTime = DateTime.Now,
                UpdateUserId = user.Id,
                UpdateUserName = user.Name
                //todo:补充或调整自己需要的字段
            });

        }
            

        public BuilderTableApp(IUnitWork unitWork, IRepository<BuilderTable> repository,
            RevelanceManagerApp app, IAuth auth) : base(unitWork, repository,auth)
        {
            _revelanceApp = app;
        }
    }
}