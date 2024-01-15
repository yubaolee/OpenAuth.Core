using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Infrastructure;
using OpenAuth.Repository.Domain;
using Quartz;

namespace OpenAuth.App.Jobs
{
    public class HttpPostJob : IJob
    {
        private SysLogApp _sysLogApp;
        private OpenJobApp _openJobApp;
        private IHttpClientFactory _httpClientFactory;

        public HttpPostJob(SysLogApp sysLogApp, OpenJobApp openJobApp, IHttpClientFactory httpClientFactory)
        {
            _sysLogApp = sysLogApp;
            _openJobApp = openJobApp;
            _httpClientFactory = httpClientFactory;
        }

        public async Task Execute(IJobExecutionContext context)
        {
            var jobId = context.MergedJobDataMap.GetString(Define.JOBMAPKEY);
            var job = _openJobApp.Get(jobId);
            if (job.JobType == 1)
            {
                using (HttpContent httpContent = new StringContent(job.JobCallParams, Encoding.UTF8))
                {
                    httpContent.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");
                    var result = await _httpClientFactory.CreateClient().PostAsync(job.JobCall, httpContent);
                    _sysLogApp.Add(new SysLog
                    {
                        CreateName = "Quartz",
                        CreateId = "Quartz",
                        TypeName = "定时任务",
                        TypeId = "AUTOJOB",
                        Content = $"定时任务自动请求{job.JobCall}返回结果：{result.Content.ReadAsStringAsync().Result}"
                    });
                }
            }
            //todo:这里可以加入自己的自动任务逻辑
            _openJobApp.RecordRun(jobId);
        }
    }
}