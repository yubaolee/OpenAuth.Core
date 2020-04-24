using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Jobs;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;
using Quartz;


namespace OpenAuth.App
{
    public class OpenJobApp : BaseApp<OpenJob>
    {
        private SysLogApp _sysLogApp;
        private IScheduler _scheduler;

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QueryOpenJobListReq request)
        {
            var result = new TableData();
            var objs = Repository.Find(null);
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.Id.Contains(request.key));
            }

            result.data = objs.OrderBy(u => u.Id)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit);
            result.count = objs.Count();
            return result;
        }

        public void Add(AddOrUpdateOpenJobReq req)
        {
            var obj = req.MapTo<OpenJob>();
            //todo:补充或调整自己需要的字段
            obj.CreateTime = DateTime.Now;
            var user = _auth.GetCurrentUser().User;
            obj.CreateUserId = user.Id;
            obj.CreateUserName = user.Name;
            Repository.Add(obj);
        }

        public void Update(AddOrUpdateOpenJobReq obj)
        {
            var user = _auth.GetCurrentUser().User;
            UnitWork.Update<OpenJob>(u => u.Id == obj.Id, u => new OpenJob
            {
                JobName = obj.JobName,
                JobType = obj.JobType,
                JobCall = obj.JobCall,
                JobCallParams = obj.JobCallParams,
                Cron = obj.Cron,
                Status = obj.Status,
                Remark = obj.Remark,
                UpdateTime = DateTime.Now,
                UpdateUserId = user.Id,
                UpdateUserName = user.Name
                //todo:补充或调整自己需要的字段
            });
        }

        #region 定时任务运行相关操作
        
        /// <summary>
        /// 返回系统的job接口
        /// </summary>
        /// <returns></returns>
        public List<string> QueryLocalHandlers()
        {
            var types = AppDomain.CurrentDomain.GetAssemblies()
                .SelectMany(a => a.GetTypes().Where(t => t.GetInterfaces()
                    .Contains(typeof(IJob))))
                .ToArray();
            return types.Select(u => u.FullName).ToList();
        }
        
        public void ChangeJobStatus(ChangeJobStatusReq req)
        {
            var job = Repository.FindSingle(u => u.Id == req.Id);
            if (job == null)
            {
                throw new Exception("任务不存在");
            }

            if (req.Status == 0) //停止
            {
                
            }
            else  //启动
            {
                _scheduler.Start();
                IJobDetail jobDetail = JobBuilder.Create<SysLogJob>().WithIdentity(job.Id).Build();
                ITrigger trigger = TriggerBuilder.Create()
                    .WithCronSchedule(job.Cron)
                    .WithIdentity(job.Id)
                    .Build();
                _scheduler.ScheduleJob(jobDetail, trigger);
            }
            
            
            var user = _auth.GetCurrentUser().User;

            job.Status = req.Status;
            job.UpdateTime = DateTime.Now;
            job.UpdateUserId = user.Id;
            job.UpdateUserName = user.Name;
            Repository.Update(job);
        }

        #endregion


        public OpenJobApp(IUnitWork unitWork, IRepository<OpenJob> repository,
            IAuth auth, SysLogApp sysLogApp, IScheduler scheduler) : base(unitWork, repository, auth)
        {
            _sysLogApp = sysLogApp;
            _scheduler = scheduler;
        }

       
    }
}