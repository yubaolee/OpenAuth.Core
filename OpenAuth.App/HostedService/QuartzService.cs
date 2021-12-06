using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Quartz;

namespace OpenAuth.App.HostedService
{
    /// <summary>
    /// 自启动服务，本服务用于启动所有状态为【正在运行】的定时任务
    /// </summary>
    public class QuartzService : IHostedService, IDisposable
    {
        private readonly ILogger<QuartzService> _logger;
        private IScheduler _scheduler;
        private OpenJobApp _openJobApp;

        public QuartzService(ILogger<QuartzService> logger, IScheduler scheduler, OpenJobApp openJobApp)
        {
            _logger = logger;
            _scheduler = scheduler;
            _openJobApp = openJobApp;
        }

        public Task StartAsync(CancellationToken cancellationToken)
        {
            _scheduler.Start();
            var result = _openJobApp.StartAll();
            return result;
        }

        public Task StopAsync(CancellationToken cancellationToken)
        {
            var result =_scheduler.Shutdown();
            _logger.LogInformation("关闭定时job");
            return result;
        }

        public void Dispose()
        {
           
        }
    }
}