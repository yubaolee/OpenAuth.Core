using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;

namespace OpenAuth.Mvc
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseUrls("http://*:1802")
                .UseStartup<Startup>();
    }
}
