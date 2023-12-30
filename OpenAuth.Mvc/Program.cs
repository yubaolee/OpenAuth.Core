using System;
using Autofac.Extensions.DependencyInjection;
using Infrastructure.Helpers;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace OpenAuth.Mvc
{
    public class Program
    {
        public static void Main(string[] args)
        {
            Console.WriteLine(@"
               ____                                 _   _       _   _      _   
              / __ \                     /\        | | | |     | \ | |    | |  
             | |  | |_ __   ___ _ __    /  \  _   _| |_| |__   |  \| | ___| |_ 
             | |  | | '_ \ / _ \ '_ \  / /\ \| | | | __| '_ \  | . ` |/ _ \ __|
             | |__| | |_) |  __/ | | |/ ____ \ |_| | |_| | | |_| |\  |  __/ |_ 
              \____/| .__/ \___|_| |_/_/    \_\__,_|\__|_| |_(_)_| \_|\___|\__|
                    | |                                                        
                    |_|                                                        
            -------------------------------------------------------------------
            Author           :  yubaolee
            Repository       :  https://gitee.com/dotnetchina/OpenAuth.Net
            -------------------------------------------------------------------
            ");
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureLogging((hostingContext, logging) =>
                {
                    logging.ClearProviders(); //去掉默认的日志
                })
               .UseServiceProviderFactory(new AutofacServiceProviderFactory())   //将默认ServiceProviderFactory指定为AutofacServiceProviderFactory
                .ConfigureWebHostDefaults(webBuilder =>
            {
                var configuration = ConfigHelper.GetConfigRoot();
                var httpHost = configuration["AppSetting:HttpHost"];
                webBuilder.UseUrls(httpHost).UseStartup<Startup>();
                Console.WriteLine($"启动成功，访问地址:{httpHost}");
            });

    }
}
