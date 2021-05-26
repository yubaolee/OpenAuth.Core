using System;
using System.Linq;
using System.Threading.Tasks;
using Infrastructure;
using Microsoft.Extensions.Logging;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class SysMessageApp : BaseStringApp<SysMessage,OpenAuthDBContext>
    {
        private RevelanceManagerApp _revelanceApp;
        private readonly ILogger<SysMessageApp> _logger;

        /// <summary>
        /// 加载列表
        /// </summary>
        public async Task<TableData> Load(QuerySysMessageListReq request)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            var result = new TableData();
            var objs = UnitWork.Find<SysMessage>(u =>u.ToId == loginContext.User.Id && u.ToStatus != -1);

            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.Title.Contains(request.key) || u.Id.Contains(request.key));
            }
            
            //过滤消息状态
            if (request.Status != 999)
            {
                objs = objs.Where(u => u.ToStatus == request.Status);
            }

            result.data = objs.OrderBy(u => u.Id)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit);
            result.count = objs.Count();
            return result;
        }

        public void Add(SysMessage obj)
        {
            Repository.Add(obj);
        }

        /// <summary>
        /// 发送指定消息给用户
        /// </summary>
        /// <param name="user"></param>
        /// <param name="message"></param>
        public void SendMsgTo(string userId, string message)
        {
            var user = UnitWork.FirstOrDefault<User>(u => u.Id == userId);
            if (user == null)
            {
                _logger.LogError($"未能找到用户{userId},不能给该用户发送消息");
                return;
            }
            Repository.Add(new SysMessage
            {
                ToId = user.Id,
                ToName = user.Name,
                FromId = Guid.Empty.ToString(),
                FromName = "系统管理员",
                Content = message,
                CreateTime = DateTime.Now
            });
        }

        /// <summary>
        /// 消息变为已读
        /// </summary>
        /// <param name="msgid"></param>
        public void Read(ReadMsgReq req)
        {
            UnitWork.Update<SysMessage>(u => u.Id == req.Id, u => new SysMessage
            {
                ToStatus = 1
            });
        }
        
        public void Del(ReadMsgReq obj)
        {
            UnitWork.Update<SysMessage>(u => u.Id == obj.Id, u => new SysMessage
            {
               ToStatus = -1 //逻辑删除
            });

        }

        public SysMessageApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<SysMessage,OpenAuthDBContext> repository,
            RevelanceManagerApp app,IAuth auth, ILogger<SysMessageApp> logger) : base(unitWork, repository, auth)
        {
            _revelanceApp = app;
            _logger = logger;
        }
    }
}