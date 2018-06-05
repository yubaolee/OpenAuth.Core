using log4net;

[assembly: log4net.Config.XmlConfigurator(Watch = true)]   
namespace Infrastructure
{
    public class LogHelper
    {
        public readonly ILog _log;

        public LogHelper(ILog log)
        {
            _log = log;
        }

        public void Log(string message)
        {
            _log.Info(message);
        }

        public void Debug(string message)
        {
            _log.Debug(message);
        }

        public void Fatal(string message)
        {
            _log.Fatal(message);
        }

        public void Warn(string message)
        {
            _log.Warn(message);
        }
    }
}
