using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Reflection;
using System.Runtime.Loader;
using System.Text;
using Infrastructure;
using Infrastructure.Helpers;
using Infrastructure.Utilities;
using Microsoft.Extensions.DependencyModel;
using Microsoft.Extensions.Options;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Core;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class BuilderTableApp : BaseApp<BuilderTable>
    {
        private BuilderTableColumnApp _builderTableColumnApp;
        private DbExtension _dbExtension;
        private string _webProject = null;
        private string _apiNameSpace = null;
        private string _startName = "";
        private IOptions<AppSetting> _appConfiguration;

        public BuilderTableApp(IUnitWork unitWork, IRepository<BuilderTable> repository,
            RevelanceManagerApp app, IAuth auth, DbExtension dbExtension, BuilderTableColumnApp builderTableColumnApp,
            IOptions<AppSetting> appConfiguration) : base(unitWork, repository, auth)
        {
            _dbExtension = dbExtension;
            _builderTableColumnApp = builderTableColumnApp;
            _appConfiguration = appConfiguration;
        }

        private string StratName
        {
            get
            {
                if (_startName == "")
                {
                    _startName = WebProject.Substring(0, _webProject.IndexOf('.'));
                }

                return _startName;
            }
        }

        private string WebProject
        {
            get
            {
                if (_webProject != null)
                    return _webProject;
                _webProject = ProjectPath.GetLastIndexOfDirectoryName(".WebApi") ??
                             ProjectPath.GetLastIndexOfDirectoryName("Api") ??
                             ProjectPath.GetLastIndexOfDirectoryName(".Mvc");
                if (_webProject == null)
                {
                    throw new Exception("未获取到以.WebApi结尾的项目名称,无法创建页面");
                }

                return _webProject;
            }
        }

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableResp<BuilderTable> Load(QueryBuilderTableListReq request)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            var result = new TableResp<BuilderTable>();
            var objs = UnitWork.Find<BuilderTable>(null);
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.Id.Contains(request.key));
            }

            result.data = objs.OrderBy(u => u.Id)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).ToList();
            result.count = objs.Count();
            return result;
        }

        public string Add(AddOrUpdateBuilderTableReq req)
        {
            if (string.IsNullOrEmpty(req.TableName))
            {
                throw new Exception("英文表名不能为空");
            }

            if (string.IsNullOrEmpty(req.ModuleName))
            {
                throw new Exception("模块名称不能为空");
            }
            
            if (string.IsNullOrEmpty(req.Namespace))
            {
                throw new Exception("命名空间不能为空");
            }
            
            var columns = _dbExtension.GetDbTableStructure(req.TableName);
            if (!columns.Any())
            {
                throw new Exception($"未能找到{req.TableName}表结构定义");
            }

            var obj = req.MapTo<BuilderTable>();
            if (string.IsNullOrEmpty(obj.ClassName)) obj.ClassName = obj.TableName;
            if (string.IsNullOrEmpty(obj.ModuleCode)) obj.ModuleCode = obj.TableName;
            
            //todo:补充或调整自己需要的字段
            obj.CreateTime = DateTime.Now;
            var user = _auth.GetCurrentUser().User;
            obj.CreateUserId = user.Id;
            obj.CreateUserName = user.Name;
            UnitWork.Add(obj);

            foreach (var column in columns)
            {
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
                    TableName = obj.TableName,
                    TableId = obj.Id,

                    CreateUserId = user.Id,
                    CreateUserName = user.Name,
                    CreateTime = DateTime.Now
                };
                UnitWork.Add(builderColumn);
            }

            UnitWork.Save();
            return obj.Id;
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
                UpdateTime = DateTime.Now,
                UpdateUserId = user.Id,
                UpdateUserName = user.Name
                //todo:补充或调整自己需要的字段
            });
        }

        /// <summary>
        /// 删除头和字段明细
        /// </summary>
        /// <param name="ids"></param>
        public void DelTableAndcolumns(string[] ids)
        {
            UnitWork.Delete<BuilderTable>(u => ids.Contains(u.Id));
            UnitWork.Delete<BuilderTableColumn>(u => ids.Contains(u.TableId));
            UnitWork.Save();
        }


        /// <summary>
        /// 生成实体Model
        /// </summary>
        /// <returns></returns>
        public void CreateEntity(CreateEntityReq req)
        {
            var sysTableInfo = Repository.FindSingle(u => u.Id == req.Id);
            var tableColumns = _builderTableColumnApp.Find(req.Id);
            if (sysTableInfo == null
                || tableColumns == null
                || tableColumns.Count == 0)
                throw new Exception("未能找到正确的模版信息");

            CheckExistsModule(sysTableInfo.ClassName);

            CreateEntityModel(tableColumns, sysTableInfo);
        }
        
        
        /// <summary>
        /// 创建业务逻辑层
        /// </summary>
        /// <returns></returns>
        public void CreateBusiness(CreateBusiReq req)
        {
            var sysTableInfo = Repository.FindSingle(u => u.Id == req.Id);
            var tableColumns = _builderTableColumnApp.Find(req.Id);
            if (sysTableInfo == null
                || tableColumns == null
                || tableColumns.Count == 0)
                throw new Exception("未能找到正确的模版信息");

            CheckExistsModule(sysTableInfo.ModuleCode);
            var nameSpace = sysTableInfo.Namespace ?? "OpenAuth.App";
            
           //创建API接口
            string apiPath = ProjectPath.GetProjectDirectoryInfo().GetDirectories()
                .Where(x => x.Name.ToLower().EndsWith(".webapi")).FirstOrDefault()?.FullName;
            if (string.IsNullOrEmpty(apiPath))
            {
                throw new Exception("未找到webapi类库,请确认是存在weiapi类库命名以.webapi结尾");
            }
            
            apiPath += $"\\Controllers\\";
            //生成Api控制器
            string domainContent = FileHelper.ReadFile(@"Template\\ControllerApi.html")
                .Replace("{TableName}", sysTableInfo.TableName)
                .Replace("{ModuleCode}", sysTableInfo.ModuleCode)
                .Replace("{ModuleName}", sysTableInfo.ModuleName)
                .Replace("{StartName}", StratName);
            FileHelper.WriteFile(apiPath, sysTableInfo.ClassName + "Controller.cs", domainContent);
            
        }

        /// <summary>
        /// 创建实体
        /// </summary>
        /// <param name="tableColumns"></param>
        /// <param name="sysTableInfo"></param>
        private void CreateEntityModel(List<BuilderTableColumn> sysColumn, BuilderTable tableInfo)
        {
            string template = "DomainModel.html";
            string domainContent = FileHelper.ReadFile("Template\\" + template);

            StringBuilder attributeBuilder = new StringBuilder();
            StringBuilder constructionBuilder = new StringBuilder();
            sysColumn = sysColumn.OrderByDescending(c => c.Sort).ToList();
            foreach (BuilderTableColumn column in sysColumn)
            {
                if (column.IsKey) continue;

                attributeBuilder.Append("/// <summary>");
                attributeBuilder.Append("\r\n");
                attributeBuilder.Append("       ///" + column.Comment + "");
                attributeBuilder.Append("\r\n");
                attributeBuilder.Append("       /// </summary>");
                attributeBuilder.Append("\r\n");

                string entityType = column.EntityType;
                if (!column.IsRequired && column.EntityType != "string")
                {
                    entityType = entityType + "?";
                }

                attributeBuilder.Append("       public " + entityType + " " + column.EntityName + " { get; set; }");
                attributeBuilder.Append("\r\n\r\n       ");

                constructionBuilder.Append("this." + column.EntityName
                                                   + "=" + GetDefault(column.EntityType)
                                                   + ";\r\n");
            }

            //获取的是本地开发代码所在目录，不是发布后的目录
            string mapPath =
                ProjectPath.GetProjectDirectoryInfo()?.FullName; //new DirectoryInfo(("~/").MapPath()).Parent.FullName;
            if (string.IsNullOrEmpty(mapPath))
            {
                throw new Exception("未找到生成的目录!");
            }

            domainContent = domainContent.Replace("{ClassName}", tableInfo.ClassName)
                .Replace("{AttributeList}", attributeBuilder.ToString())
                .Replace("{Construction}", constructionBuilder.ToString());


            var tableAttr = new StringBuilder();

            tableAttr.Append("/// <summary>");
            tableAttr.Append("\r\n");
            tableAttr.Append("       ///" + tableInfo.Comment + "");
            tableAttr.Append("\r\n");
            tableAttr.Append("       /// </summary>");
            tableAttr.Append("\r\n");
            tableAttr.Append("[Table(\"" + tableInfo.TableName + "\")]");
            domainContent = domainContent.Replace("{AttributeManager}", tableAttr.ToString());

            string folderName = string.IsNullOrEmpty(tableInfo.Folder) ? "" : tableInfo.Folder + "\\";
            FileHelper.WriteFile(
                mapPath +
                $"\\OpenAuth.Repository\\Domain\\{folderName}", tableInfo.ClassName + ".cs",
                domainContent);
        }

        private bool IsMysql()
        {
            return (_appConfiguration.Value.DbType == Define.DBTYPE_MYSQL);
        }

        string GetDefault(string type)
        {
            Type t = Type.GetType(type);
            if (t == null)
            {
                return string.Empty;
            }

            if (t.IsValueType)
            {
                return Activator.CreateInstance(t).ToString();
            }

            return string.Empty;
        }

        /// <summary>
        /// 校验模块是否已经存在
        /// </summary>
        /// <param name="moduleName"></param>
        /// <param name="moduleCode"></param>
        /// <exception cref="Exception"></exception>
        public void CheckExistsModule(string moduleCode)
        {
            //如果是第一次创建model，此处反射获取到的是已经缓存过的文件，必须重新运行项目否则新增的文件无法做判断文件是否创建，需要重新做反射实际文件，待修改...
            var compilationLibrary = DependencyContext
                .Default
                .CompileLibraries
                .Where(x => !x.Serviceable && x.Type == "project");
            foreach (var compilation in compilationLibrary)
            {
                var types = AssemblyLoadContext.Default
                    .LoadFromAssemblyName(new AssemblyName(compilation.Name))
                    .GetTypes().Where(x => x.GetTypeInfo().BaseType != null
                                           && x.BaseType == typeof(Entity));
                foreach (var entity in types)
                {
                    if (entity.Name == moduleCode )
                        throw new Exception($"实际表名【{moduleCode}】已创建实体，不能创建实体");

                    if (entity.Name != moduleCode)
                    {
                        var tableAttr = entity.GetCustomAttribute<TableAttribute>();
                        if (tableAttr != null && tableAttr.Name == moduleCode)
                        {
                            throw new Exception(
                                $"实际表名【{moduleCode}】已被创建建实体,不能创建");
                        }
                    }
                }
            }
        }

        public void CreateVue(CreateVueReq createVueReq)
        {
            throw new NotImplementedException();
        }
    }
}

