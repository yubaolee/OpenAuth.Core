# 定时任务

::: tip 提示
定时任务基于Quartz.Net开发
:::

## 编写任务代码

在OpenAuth.App中编写定时任务的执行代码。比如`TestJob`

```csharp
namespace OpenAuth.App.Jobs
{
    public class TestJob : IJob
    {
        private OpenJobApp _openJobApp;

        public TestJob(OpenJobApp openJobApp)
        {
            _openJobApp = openJobApp;
        }

        public Task Execute(IJobExecutionContext context)
        {
            var jobId = context.MergedJobDataMap.GetString(Define.JOBMAPKEY);
            //todo:获取到定时任务的id，可以可以加入自己的自动任务逻辑
            _openJobApp.RecordRun(jobId);
            return Task.Delay(1);
        }
    }
}
```

## 添加任务执行规则

编写完任务的执行代码后即可运行系统，在界面【基础配置】-【定时任务】中添加任务的执行规则，如图：

![](/addjob.png)

添加任务规则后，在界面直接点击`启用`即可


::: tip 提示
企业版提供可视化的CRON编辑界面,如图：

![](/addjobpro.png)
:::

