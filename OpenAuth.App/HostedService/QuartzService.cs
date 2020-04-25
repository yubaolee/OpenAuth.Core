using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Quartz;

namespace OpenAuth.App.HostedService
{
    public class QuartzService : IHostedService, IDisposable
    {
        private readonly ILogger<QuartzService> _logger;
        private IScheduler _scheduler;

        public QuartzService(ILogger<QuartzService> logger, IScheduler scheduler)
        {
            _logger = logger;
            _scheduler = scheduler;
        }

        public Task StartAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("启动定时job，可以在这里配置读取数据库需要启动的任务，然后启动他们");
            _scheduler.Start();
            return Task.CompletedTask;
        }

        public Task StopAsync(CancellationToken cancellationToken)
        {
            _scheduler.Shutdown();
            _logger.LogInformation("关闭定时job");
            return Task.CompletedTask;
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}