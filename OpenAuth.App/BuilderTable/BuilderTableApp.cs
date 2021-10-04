using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.Loader;
using System.Text;
using System.Threading.Tasks;
using Infrastructure;
using Infrastructure.Extensions;
using Infrastructure.Helpers;
using Infrastructure.Utilities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyModel;
using Microsoft.Extensions.Options;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository;
using OpenAuth.Repository.Core;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class BuilderTableApp : BaseStringApp<BuilderTable,OpenAuthDBContext>
    {
        private BuilderTableColumnApp _builderTableColumnApp;
        private CategoryApp _categoryApp;
        private DbExtension _dbExtension;
        private string _webProject = string.Empty;
        private string _startName = "";
        private IOptions<AppSetting> _appConfiguration;

        public BuilderTableApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<BuilderTable,OpenAuthDBContext> repository,
            RevelanceManagerApp app, IAuth auth, DbExtension dbExtension, BuilderTableColumnApp builderTableColumnApp,
            IOptions<AppSetting> appConfiguration, CategoryApp categoryApp) : base(unitWork, repository, auth)
        {
            _dbExtension = dbExtension;
            _builderTableColumnApp = builderTableColumnApp;
            _appConfiguration = appConfiguration;
            _categoryApp = categoryApp;
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
                if (string.IsNullOrEmpty(_webProject))
                    return _webProject;
                _webProject = ProjectPath.GetLastIndexOfDirectoryName(".WebApi") ??
                             ProjectPath.GetLastIndexOfDirectoryName("Api") ??
                             ProjectPath.GetLastIndexOfDirectoryName(".Mvc");
                if (string.IsNullOrEmpty(_webProject))
                {
                    throw new Exception("未获取到以.WebApi结尾的项目名称,无法创建页面");
                }

                return _webProject;
            }
        }

        /// <summary>
        /// 加载列表
        /// </summary>
        public async Task<TableResp<BuilderTable>> Load(QueryBuilderTableListReq request)
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

            result.data =await objs.OrderBy(u => u.Id)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).ToListAsync();
            result.count =await objs.CountAsync();
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
            
            var obj = AddTableAndColumns(req.MapTo<BuilderTable>());

            //创建子表
            if (!string.IsNullOrEmpty(req.DetailTableName))
            {
                AddTableAndColumns(new BuilderTable
                {
                    TableName = req.DetailTableName,
                    ParentTableId = obj.Id,
                    Namespace = "OpenAuth.Repository.Domain",
                    ModuleName = req.DetailTableName,
                    Folder = req.Folder,
                    TypeId = req.TypeId,
                    TypeName = req.TypeName
                });
            }
            
            UnitWork.Save();
            return obj.Id;
        }

        /// <summary>
        /// 添加表结构及字段结构记录
        /// </summary>
        private BuilderTable AddTableAndColumns(BuilderTable obj)
        {
            if (string.IsNullOrEmpty(obj.ClassName)) obj.ClassName = obj.TableName;
            if (string.IsNullOrEmpty(obj.ModuleCode)) obj.ModuleCode = obj.TableName;

            //todo:补充或调整自己需要的字段
            obj.CreateTime = DateTime.Now;
            var user = _auth.GetCurrentUser().User;
            obj.CreateUserId = user.Id;
            obj.CreateUserName = user.Name;
            UnitWork.Add(obj);

            var columns = _dbExtension.GetDbTableStructure(obj.TableName);
            if (!columns.Any())
            {
                throw new Exception($"未能找到{obj.TableName}表结构定义");
            }
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

            return obj;
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
                IsDynamicHeader = obj.IsDynamicHeader,
                ForeignKey = obj.ForeignKey,
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
            UnitWork.ExecuteWithTransaction(() =>
            {
                UnitWork.Delete<BuilderTable>(u => ids.Contains(u.Id));
                UnitWork.Delete<BuilderTableColumn>(u => ids.Contains(u.TableId));
                UnitWork.Save();
            });
        }


        /// <summary>
        /// 生成实体Model
        /// </summary>
        /// <returns></returns>
        public void CreateEntity(CreateEntityReq req)
        {
            var sysTableInfo = Repository.FirstOrDefault(u => u.Id == req.Id);
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
            var sysTableInfo = Repository.FirstOrDefault(u => u.Id == req.Id);
            var mainColumns = _builderTableColumnApp.Find(req.Id);
            if (sysTableInfo == null
                || mainColumns == null
                || mainColumns.Count == 0)
                throw new Exception("未能找到正确的模版信息");

                //生成应用层
            GenerateApp(sysTableInfo, mainColumns);

            //生成应用层的请求参数
            GenerateAppReq(sysTableInfo, mainColumns);
            
            //生成WebApI接口
            GenerateWebApi(sysTableInfo, mainColumns);
        }

        /// <summary>
        /// 创建应用层
        /// </summary>
        /// <param name="sysTableInfo"></param>
        /// <exception cref="Exception"></exception>
        private void GenerateApp(BuilderTable sysTableInfo, List<BuilderTableColumn> sysColumns)
        {
            string appRootPath = ProjectPath.GetProjectDirectoryInfo()
                .GetDirectories().FirstOrDefault(x => x.Name.ToLower().EndsWith(".app"))?.FullName;
            if (string.IsNullOrEmpty(appRootPath))
            {
                throw new Exception("未找到openauth.app类库,请确认是否存在");
            }

            CheckExistsModule(sysTableInfo.ModuleCode);

            string domainContent = string.Empty;
            if (sysTableInfo.IsDynamicHeader)   //使用动态头部的模版
            {
                domainContent = FileHelper.ReadFile(@"Template\\SingleTable\\BuildAppWithDynamicHeader.html");
            }
            else
            {
                domainContent = FileHelper.ReadFile(@"Template\\SingleTable\\BuildApp.html");
            }
                domainContent = domainContent
                .Replace("{TableName}", sysTableInfo.TableName)
                .Replace("{ModuleCode}", sysTableInfo.ModuleCode)
                .Replace("{ModuleName}", sysTableInfo.ModuleName)
                .Replace("{ClassName}", sysTableInfo.ClassName)
                .Replace("{StartName}", StratName);

                if (!string.IsNullOrEmpty(sysTableInfo.ForeignKey))
                {   //替换外键模版
                    var foreignTemplate = $"objs = objs.Where(u => u.{sysTableInfo.ForeignKey} == request.{sysTableInfo.ForeignKey});";
                    domainContent = domainContent
                        .Replace("{ForeignKeyTemplate}", foreignTemplate);
                }
                else
                {
                    domainContent = domainContent
                        .Replace("{ForeignKeyTemplate}", "");
                }
                
                var primarykey = sysColumns.FirstOrDefault(u => u.IsKey);
                if (primarykey == null)
                {
                    throw new Exception($"未能找到表{sysTableInfo.TableName}的主键字段");
                }
                if (primarykey.ColumnType == "decimal" || primarykey.ColumnType == "numeric") //是否为数字
                {
                    if(primarykey.IsIncrement) //是否自增
                    {
                        domainContent = domainContent.Replace("{BaseAppName}", "BaseIntAutoGenApp");
                    }
                    else //普通的雪花算法生成id
                    {
                        domainContent = domainContent.Replace("{BaseAppName}", "BaseLongApp");
                    }
                }
                else 
                {
                    domainContent = domainContent.Replace("{BaseAppName}", "BaseStringApp");
                }
            FileHelper.WriteFile($"{appRootPath}\\{sysTableInfo.ModuleCode}", $"{sysTableInfo.ModuleCode}.cs", domainContent);
        }
        
        /// <summary>
        /// 生成APP层的请求参数
        /// </summary>
        /// <param name="sysTableInfo"></param>
        /// <param name="tableColumns"></param>
        private void GenerateAppReq(BuilderTable sysTableInfo, List<BuilderTableColumn> tableColumns)
        {
            string appRootPath = ProjectPath.GetProjectDirectoryInfo()
                .GetDirectories().FirstOrDefault(x => x.Name.ToLower().EndsWith(".app"))?.FullName;
            if (string.IsNullOrEmpty(appRootPath))
            {
                throw new Exception("未找到openauth.app类库,请确认是否存在");
            }
            string domainContent;
            domainContent = FileHelper.ReadFile(@"Template\\BuildQueryReq.html")
                .Replace("{TableName}", sysTableInfo.TableName)
                .Replace("{ModuleCode}", sysTableInfo.ModuleCode)
                .Replace("{ModuleName}", sysTableInfo.ModuleName)
                .Replace("{ClassName}", sysTableInfo.ClassName)
                .Replace("{StartName}", StratName);

            if (!string.IsNullOrEmpty(sysTableInfo.ForeignKey))
            {   //替换外键模版
                var foreignTemplate = $" public string {sysTableInfo.ForeignKey} {{ get; set; }}";
                domainContent = domainContent
                    .Replace("{ForeignKeyTemplate}", foreignTemplate);
            }
            else
            {
                domainContent = domainContent
                    .Replace("{ForeignKeyTemplate}", "");
            }

            FileHelper.WriteFile(Path.Combine(appRootPath, $"{sysTableInfo.ModuleCode}\\Request"), $"Query{sysTableInfo.ClassName}ListReq.cs",
                domainContent);


            domainContent = FileHelper.ReadFile(@"Template\\BuildUpdateReq.html");

            StringBuilder attributeBuilder = new StringBuilder();
            var sysColumn = tableColumns.OrderByDescending(c => c.Sort).ToList();
            foreach (BuilderTableColumn column in sysColumn)
            {
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
            }

            domainContent = domainContent.Replace("{ClassName}", sysTableInfo.ClassName)
                .Replace("{AttributeList}", attributeBuilder.ToString());

            var tableAttr = new StringBuilder();
            tableAttr.Append("/// <summary>");
            tableAttr.Append("\r\n");
            tableAttr.Append("       ///" + sysTableInfo.Comment + "");
            tableAttr.Append("\r\n");
            tableAttr.Append("       /// </summary>");
            tableAttr.Append("\r\n");
            domainContent = domainContent.Replace("{AttributeManager}", tableAttr.ToString());

            FileHelper.WriteFile(Path.Combine(appRootPath, $"{sysTableInfo.ModuleCode}\\Request"), $"AddOrUpdate{sysTableInfo.ClassName}Req.cs",
                domainContent);
        }

        /// <summary>
        /// 创建WebAPI接口
        /// </summary>
        /// <param name="sysTableInfo"></param>
        /// <exception cref="Exception"></exception>
        private void GenerateWebApi(BuilderTable sysTableInfo, List<BuilderTableColumn> sysColumns)
        {
            string domainContent;
            string apiPath = ProjectPath.GetProjectDirectoryInfo()
                .GetDirectories().FirstOrDefault(x => x.Name.ToLower().EndsWith(".webapi"))?.FullName;
            if (string.IsNullOrEmpty(apiPath))
            {
                throw new Exception("未找到webapi类库,请确认是存在weiapi类库命名以.webapi结尾");
            }

            var controllerName = sysTableInfo.ClassName + "sController";
            CheckExistsModule(controllerName); //单元测试下无效，因为没有执行webapi项目
            var controllerPath = apiPath + $"\\Controllers\\";
            domainContent = FileHelper.ReadFile(@"Template\\BuildControllerApi.html")
                .Replace("{TableName}", sysTableInfo.TableName)
                .Replace("{ModuleCode}", sysTableInfo.ModuleCode)
                .Replace("{ModuleName}", sysTableInfo.ModuleName)
                .Replace("{ClassName}", sysTableInfo.ClassName)
                .Replace("{StartName}", StratName);
                
                var primarykey = sysColumns.FirstOrDefault(u => u.IsKey);
                if (primarykey == null)
                {
                    throw new Exception($"未能找到表{sysTableInfo.TableName}的主键字段");
                }
                if (primarykey.ColumnType == "decimal" || primarykey.ColumnType == "numeric") //是否为数字
                {
                    if(primarykey.IsIncrement) //是否自增
                    {
                        domainContent = domainContent.Replace("{KeyTypeName}", "int");
                    }
                    else //普通的雪花算法生成id
                    {
                        domainContent = domainContent.Replace("{KeyTypeName}", "decimal");
                    }
                }
                else 
                {
                    domainContent = domainContent.Replace("{KeyTypeName}", "string");
                }
            FileHelper.WriteFile(controllerPath, controllerName + ".cs", domainContent);
        }
        
        /// <summary>
        /// 创建实体
        /// </summary>
        /// <param name="tableColumns"></param>
        /// <param name="sysTableInfo"></param>
        private void CreateEntityModel(List<BuilderTableColumn> sysColumns, BuilderTable tableInfo)
        {
            string template = "BuildEntity.html";
            string domainContent = FileHelper.ReadFile("Template\\" + template);

            StringBuilder attributeBuilder = new StringBuilder();
            StringBuilder constructionBuilder = new StringBuilder();   //生成构造函数初始化值
            sysColumns = sysColumns.OrderByDescending(c => c.Sort).ToList();
            foreach (BuilderTableColumn column in sysColumns)
            {
                if (column.IsKey) continue;

                attributeBuilder.Append("/// <summary>");
                attributeBuilder.Append("\r\n");
                attributeBuilder.Append("       ///" + column.Comment + "");
                attributeBuilder.Append("\r\n");
                attributeBuilder.Append("       /// </summary>");
                attributeBuilder.Append("\r\n");
                
                attributeBuilder.Append("       [Description(\""+ column.Comment +"\")]");
                attributeBuilder.Append("\r\n");

                string entityType = column.EntityType;
                if (!column.IsRequired && column.EntityType != "string")
                {
                    entityType = entityType + "?";
                }

                attributeBuilder.Append("       public " + entityType + " " + column.EntityName + " { get; set; }");
                attributeBuilder.Append("\r\n\r\n       ");

                constructionBuilder.Append("       this." + column.EntityName
                                                   + "=" + (GetDefault(column.EntityType)??"\"\"")
                                                   + ";\r\n");
            }

            //获取的是本地开发代码所在目录，不是发布后的目录
            string mapPath =
                ProjectPath.GetProjectDirectoryInfo()?.FullName; //new DirectoryInfo(("~/").MapPath()).Parent.FullName;
            if (string.IsNullOrEmpty(mapPath))
            {
                throw new Exception("未找到生成的目录!");
            }

            var primarykey = sysColumns.FirstOrDefault(u => u.IsKey);
            if (primarykey == null)
            {
                throw new Exception($"未能找到表{tableInfo.TableName}的主键字段");
            }
            if (primarykey.ColumnType == "decimal" || primarykey.ColumnType == "numeric") //是否为数字
            {
                if(primarykey.IsIncrement) //是否自增
                {
                    domainContent = domainContent.Replace("{BaseEntityName}", "IntAutoGenEntity");
                }
                else //普通的雪花算法生成id
                {
                    domainContent = domainContent.Replace("{BaseEntityName}", "LongEntity");
                }
            }
            else 
            {
                domainContent = domainContent.Replace("{BaseEntityName}", "StringEntity");
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
            tableAttr.Append("       [Table(\"" + tableInfo.TableName + "\")]");
            domainContent = domainContent.Replace("{AttributeManager}", tableAttr.ToString());

            FileHelper.WriteFile(
                mapPath +
                $"\\OpenAuth.Repository\\Domain\\", tableInfo.ClassName + ".cs",
                domainContent);

            string openAuthDBContextPath = mapPath + "\\OpenAuth.Repository\\OpenAuthDBContext.cs";
            FileHelper.RegxAddContentByParenthesis(openAuthDBContextPath, "public virtual DbSet<" + tableInfo.ClassName + "> " + tableInfo.TableName + "s { get; set; }");
        }

        Dictionary<string, Type> PrimitiveTypes = new Dictionary<string, Type>()
        {
            {"int", typeof(int)}
            ,{"long", typeof(long)}
            ,{"string", typeof(string)}
            ,{"bool", typeof(bool)}
            ,{"byte", typeof(byte)}
            ,{"char", typeof(char)}
            ,{"decimal", typeof(decimal)}
            ,{"double", typeof(double)}
            ,{"DateTime", typeof(DateTime)}
        };
        string? GetDefault(string type)
        {
            Type t = PrimitiveTypes[type];
            if (t == null)
            {
                return null;
            }

            if (t.IsValueType)
            {
                if (type == "DateTime")
                {
                    return "DateTime.Now";
                }
                return Activator.CreateInstance(t).ToString();
            }

            return null;
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
                                           && x.BaseType == typeof(StringEntity));
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

        /// <summary>
        /// 创建vue界面
        /// </summary>
        /// <param name="req"></param>
        /// <exception cref="Exception"></exception>
        public void CreateVue(CreateVueReq req)
        {
            if (string.IsNullOrEmpty(req.VueProjRootPath))
            {
                throw new Exception("请提供vue项目的根目录,如：C:\\OpenAuth.Pro\\Client");
            }
            var sysTableInfo = Repository.FirstOrDefault(u => u.Id == req.Id);

            if (!string.IsNullOrEmpty(sysTableInfo.ParentTableId))
            {
                throw new Exception("子表不能直接生成vue，请使用该表对应的父表生成vue或删除该表的父表");
            }

            var tableColumns = _builderTableColumnApp.Find(req.Id);
            if (sysTableInfo == null
                || tableColumns == null
                || tableColumns.Count == 0)
                throw new Exception("未能找到正确的模版信息");

            string domainContent = string.Empty;

            //查找是否存在子表额情况
            var subTable = Repository.FirstOrDefault(u => u.ParentTableId == req.Id);
            
            if (subTable == null)  //如果子表不存在，则用单模版生成
            {
                if (sysTableInfo.IsDynamicHeader) 
                {
                    domainContent = FileHelper.ReadFile(@"Template\\SingleTable\\BuildVueWithDynamicHeader.html");
                }
                else
                {
                    domainContent = FileHelper.ReadFile(@"Template\\SingleTable\\BuildVue.html");
                }

               domainContent = domainContent.Replace("{ClassName}", sysTableInfo.ClassName)
                    .Replace("{TableName}", sysTableInfo.ClassName.ToCamelCase())
                    .Replace("{HeaderList}", BuilderHeader(tableColumns).ToString());
            }
            else //如果存在子表，则使用主从表生成
            {
                var subTableColumns = _builderTableColumnApp.Find(subTable.Id);
                if (subTableColumns.Count == 0)
                    throw new Exception($"未找到子表{subTable.ClassName}的字段定义");

                if (sysTableInfo.IsDynamicHeader)
                {
                    domainContent = FileHelper.ReadFile(@"Template\\MultiTable\\BuildVueWithDynamicHeader.html");
                }
                else
                {
                    domainContent = FileHelper.ReadFile(@"Template\\MultiTable\\BuildVue.html");
                }

                domainContent = domainContent.Replace("{ParentTableId}", subTable.ForeignKey.ToCamelCase())
                    .Replace("{FirstTableName}", sysTableInfo.ClassName.ToCamelCase())
                    .Replace("{SecondTableName}", subTable.ClassName.ToCamelCase())
                    .Replace("{FirstHeaderList}", BuilderHeader(tableColumns).ToString())
                    .Replace("{SecondHeaderList}", BuilderHeader(subTableColumns).ToString());
            }




            
            FileHelper.WriteFile(Path.Combine(req.VueProjRootPath, $"src/views/{sysTableInfo.ClassName.ToLower()}s/"), 
                $"index.vue",
                domainContent);
        }

        /// <summary>
        /// 创建vue动态表头
        /// </summary>
        /// <returns></returns>
        private StringBuilder BuilderHeader(List<BuilderTableColumn> tableColumns)
        {
            StringBuilder headerListBuilder = new StringBuilder(); //临时类的默认值属性
            var syscolums = tableColumns.OrderByDescending(c => c.Sort).ToList();

            //string[] eidtTye = new string[] { "select", "selectList", "checkbox" };
            //if (syscolums.Exists(x => eidtTye.Contains(x.EditType) && string.IsNullOrEmpty(x.DataSource)))
            //{
            //    throw new Exception($"编辑类型为[{string.Join(',', eidtTye)}]时必须选择数据源");
            //}

            foreach (BuilderTableColumn column in syscolums)
            {
                headerListBuilder.Append(
                    $" new ColumnDefine('{column.ColumnName.ToCamelCase()}', '{column.Comment}', {column.IsEdit}, {column.IsList}, '{column.EditType}', '{column.DataSource}', '{column.EntityType}', '{column.ColumnType}', '{column.EntityName}'),");
            }

            return headerListBuilder;
        }

        /// <summary>
        /// 创建vue接口
        /// </summary>
        /// <param name="req"></param>
        /// <exception cref="Exception"></exception>
        public void CreateVueApi(CreateVueReq req)
        {
            if (string.IsNullOrEmpty(req.VueProjRootPath))
            {
                throw new Exception("请提供vue项目的根目录,如：C:\\OpenAuth.Pro\\Client");
            }
            var sysTableInfo = Repository.FirstOrDefault(u => u.Id == req.Id);
            var tableColumns = _builderTableColumnApp.Find(req.Id);
            if (sysTableInfo == null
                || tableColumns == null
                || tableColumns.Count == 0)
                throw new Exception("未能找到正确的模版信息");
            
            var domainContent = FileHelper.ReadFile(@"Template\\BuildVueApi.html");

            domainContent = domainContent.Replace("{TableName}", sysTableInfo.ClassName.ToCamelCase());
            
            FileHelper.WriteFile(Path.Combine(req.VueProjRootPath, $"src/api/"),$"{sysTableInfo.ClassName.ToCamelCase()}s.js", 
                domainContent);
        }
        
        /// <summary>
        /// 加载所有的主表（parentId为空的）
        /// </summary>
        /// <returns></returns>
        public async Task<TableData> AllMain()
        {
            var result = new TableData();
            var objs = UnitWork.Find<BuilderTable>(u =>string.IsNullOrEmpty(u.ParentTableId)).Select(u=>new
            {
                Id= u.Id,
                Name = u.TableName
            });

            result.data =await objs.OrderBy(u => u.Id).ToListAsync();
            result.count =await objs.CountAsync();
            return result;
        }
    }
}

