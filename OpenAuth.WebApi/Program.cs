using System;
using Autofac.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace OpenAuth.WebApi
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
            .Net 5 Repository:  https://gitee.com/dotnetchina/OpenAuth.Net
            .Net core 3.1    :  https://gitee.com/yubaolee/OpenAuth.Core
            -------------------------------------------------------------------
            ");
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureLogging((hostingContext, logging) =>
                {
                    logging.ClearProviders(); //去掉默认的日志
                    // logging.AddLog4Net();
                })
                .UseServiceProviderFactory(
                    new AutofacServiceProviderFactory()) //将默认ServiceProviderFactory指定为AutofacServiceProviderFactory
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseUrls("http://*:52789").UseStartup<Startup>();
                });
    }
}