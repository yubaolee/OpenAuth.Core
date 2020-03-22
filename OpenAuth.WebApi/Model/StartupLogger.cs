

using Microsoft.Extensions.Logging;

namespace OpenAuth.WebApi.Model
{
    /// <summary>
    /// 从3.0开始Startup ConfigureServices中不能使用ILogger，需要扩展
    /// </summary>
    public class StartupLogger
    {
        private readonly ILogger<StartupLogger> _logger;

        public StartupLogger(ILogger<StartupLogger> logger)
        {
            _logger = logger;
        }

        public void LogInformation(string message)
        {
            _logger.LogInformation(message);
        }
    }
}