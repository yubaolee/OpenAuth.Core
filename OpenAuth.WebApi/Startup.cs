using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using Autofac;
using IdentityServer4.AccessTokenValidation;
using Infrastructure;
using Infrastructure.Extensions.AutofacManager;
using Infrastructure.Middleware;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json;
using OpenAuth.App;
using OpenAuth.App.HostedService;
using OpenAuth.Repository;
using OpenAuth.WebApi.Model;
using Swashbuckle.AspNetCore.SwaggerUI;

namespace OpenAuth.WebApi
{
    public class Startup
    {
        public IHostEnvironment Environment { get; }
        public IConfiguration Configuration { get; }

        public Startup(IConfiguration configuration, IHostEnvironment environment)
        {
            Configuration = configuration;
            Environment = environment;
        }


        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            //在startup中需要强制创建log4net
            var loggerFactory = LoggerFactory.Create(builder => { builder.AddLog4Net(); });
            ILogger logger = loggerFactory.CreateLogger<Startup>();

            var identityServer =
                ((ConfigurationSection) Configuration.GetSection("AppSetting:IdentityServerUrl")).Value;
            if (!string.IsNullOrEmpty(identityServer))
            {
                services.AddAuthorization();

                services.AddAuthentication(IdentityServerAuthenticationDefaults.AuthenticationScheme)
                    .AddJwtBearer(options =>
                    {
                        options.Authority = identityServer;
                        options.RequireHttpsMetadata = false; // 指定是否为HTTPS
                        options.Audience = "openauthapi";
                    });
            }

            // 添加MiniProfiler服务
            services.AddMiniProfiler(options =>
            {
                // 设定访问分析结果URL的路由基地址
                options.RouteBasePath = "/profiler";

                options.ColorScheme = StackExchange.Profiling.ColorScheme.Auto;
                options.PopupRenderPosition = StackExchange.Profiling.RenderPosition.BottomLeft;
                options.PopupShowTimeWithChildren = true;
                options.PopupShowTrivial = true;
                options.SqlFormatter = new StackExchange.Profiling.SqlFormatters.InlineFormatter();
                //  options.IgnoredPaths.Add("/swagger/");
            }).AddEntityFramework(); //显示SQL语句及耗时

            //添加swagger
            services.AddSwaggerGen(option =>
            {
                foreach (var controller in GetControllers())
                {
                    var groupname = GetSwaggerGroupName(controller);

                    option.SwaggerDoc(groupname, new OpenApiInfo
                    {
                        Version = "v1",
                        Title = groupname,
                        Description = "by yubaolee"
                    });
                }

                logger.LogInformation($"api doc basepath:{AppContext.BaseDirectory}");
                foreach (var name in Directory.GetFiles(AppContext.BaseDirectory, "*.*",
                    SearchOption.AllDirectories).Where(f => Path.GetExtension(f).ToLower() == ".xml"))
                {
                    option.IncludeXmlComments(name, includeControllerXmlComments: true);
                    // logger.LogInformation($"find api file{name}");
                }

                option.OperationFilter<GlobalHttpHeaderOperationFilter>(); // 添加httpHeader参数

                if (!string.IsNullOrEmpty(identityServer))
                {
                    //接入identityserver
                    option.AddSecurityDefinition("oauth2", new OpenApiSecurityScheme
                    {
                        Type = SecuritySchemeType.OAuth2,
                        Description = "OAuth2登陆授权",
                        Flows = new OpenApiOAuthFlows
                        {
                            Implicit = new OpenApiOAuthFlow
                            {
                                AuthorizationUrl = new Uri($"{identityServer}/connect/authorize"),
                                Scopes = new Dictionary<string, string>
                                {
                                    {"openauthapi", "同意openauth.webapi 的访问权限"} //指定客户端请求的api作用域。 如果为空，则客户端无法访问
                                }
                            }
                        }
                    });
                    option.OperationFilter<AuthResponsesOperationFilter>();
                }
            });
            services.Configure<AppSetting>(Configuration.GetSection("AppSetting"));
            services.AddControllers(option => { option.Filters.Add<OpenAuthFilter>(); })
                .ConfigureApiBehaviorOptions(options =>
                {
                    // 禁用自动模态验证
                    // options.SuppressModelStateInvalidFilter = true;

                    //启动WebAPI自动模态验证，处理返回值
                    options.InvalidModelStateResponseFactory = context =>
                    {
                        var problems = new CustomBadRequest(context);

                        return new BadRequestObjectResult(problems);
                    };
                }).AddNewtonsoftJson(options =>
                {
                    //忽略循环引用
                    options.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
                    //不使用驼峰样式的key
                    //options.SerializerSettings.ContractResolver = new DefaultContractResolver();    
                    options.SerializerSettings.DateFormatString = "yyyy-MM-dd HH:mm:ss";
                });
            services.AddMemoryCache();
            services.AddCors();
//          todo:如果正式 环境请用下面的方式限制随意访问跨域
//            var origins = new []
//            {
//                "http://localhost:1803",
//                "http://localhost:52789"
//            };
//            if (Environment.IsProduction())
//            {
//                origins = new []
//                {
//                    "http://demo.openauth.net.cn:1803",
//                    "http://demo.openauth.net.cn:52789"
//                };
//            }
//            services.AddCors(option=>option.AddPolicy("cors", policy =>
//                policy.AllowAnyHeader().AllowAnyMethod().AllowCredentials().WithOrigins(origins)));

            //在startup里面只能通过这种方式获取到appsettings里面的值，不能用IOptions😰
            var dbtypes = ((ConfigurationSection) Configuration.GetSection("AppSetting:DbTypes")).GetChildren()
                .ToDictionary(x => x.Key, x => x.Value);
            var connectionString = Configuration.GetConnectionString("OpenAuthDBContext");
            logger.LogInformation($"系统配置的数据库类型：{JsonHelper.Instance.Serialize(dbtypes)}，连接字符串：{connectionString}");
            services.AddDbContext<OpenAuthDBContext>();

            services.AddHttpClient();

            services.AddDataProtection().PersistKeysToFileSystem(new DirectoryInfo(Configuration["DataProtection"]));


            //设置定时启动的任务
            services.AddHostedService<QuartzService>();
        }

        public void ConfigureContainer(ContainerBuilder builder)
        {
            AutofacExt.InitAutofac(builder);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostEnvironment env, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddLog4Net();

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseMiniProfiler();

            //可以访问根目录下面的静态文件
            var staticfile = new StaticFileOptions
            {
                FileProvider = new PhysicalFileProvider(AppContext.BaseDirectory),
                OnPrepareResponse = (ctx) =>
                {
                    //可以在这里为静态文件添加其他http头信息，默认添加跨域信息
                    ctx.Context.Response.Headers["Access-Control-Allow-Origin"] = "*";
                }
            };
            app.UseStaticFiles(staticfile);


            //todo:测试可以允许任意跨域，正式环境要加权限
            app.UseCors(builder => builder.AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader());

            app.UseRouting();
            app.UseAuthentication();

            // 启用日志追踪记录和异常友好提示
            app.UseLogMiddleware();

            app.UseEndpoints(endpoints => { endpoints.MapControllers(); });

            //配置ServiceProvider
            AutofacContainerModule.ConfigServiceProvider(app.ApplicationServices);


            app.UseSwagger();

            // Enable middleware to serve swagger-ui (HTML, JS, CSS, etc.), 
            // specifying the Swagger JSON endpoint.
            app.UseSwaggerUI(c =>
            {
                c.IndexStream = () =>
                    GetType().GetTypeInfo().Assembly.GetManifestResourceStream("OpenAuth.WebApi.index.html");

                foreach (var controller in GetControllers())
                {
                    var groupname = GetSwaggerGroupName(controller);

                    c.SwaggerEndpoint($"/swagger/{groupname}/swagger.json", groupname);
                }

                c.DocExpansion(DocExpansion.List); //默认展开列表
                c.OAuthClientId("OpenAuth.WebApi"); //oauth客户端名称
                c.OAuthAppName("开源版webapi认证"); // 描述
            });
        }

        /// <summary>
        /// 获取控制器对应的swagger分组值
        /// </summary>
        private string GetSwaggerGroupName(Type controller)
        {
            var groupname = controller.Name.Replace("Controller", "");
            var apisetting = controller.GetCustomAttribute(typeof(ApiExplorerSettingsAttribute));
            if (apisetting != null)
            {
                groupname = ((ApiExplorerSettingsAttribute) apisetting).GroupName;
            }

            return groupname;
        }

        /// <summary>
        /// 获取所有的控制器
        /// </summary>
        private List<Type> GetControllers()
        {
            Assembly asm = Assembly.GetExecutingAssembly();

            var controlleractionlist = asm.GetTypes()
                .Where(type => typeof(ControllerBase).IsAssignableFrom(type))
                .OrderBy(x => x.Name).ToList();
            return controlleractionlist;
        }
    }
}