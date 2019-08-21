using System;
using System.Linq;
using Infrastructure;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class SysMessageApp : BaseApp<SysMessage>
    {
        private RevelanceManagerApp _revelanceApp;
        private IAuth _auth;

        /// <summary>
        /// 加载列表
        /// </summary>
        public TableData Load(QuerySysMessageListReq request)
        {
            var loginContext = _auth.GetCurrentUser();
            if (loginContext == null)
            {
                throw new CommonException("登录已过期", Define.INVALID_TOKEN);
            }

            var properties = loginContext.GetProperties("SysMessage");

            if (properties == null || properties.Count == 0)
            {
                throw new Exception("当前登录用户没有访问该模块字段的权限，请联系管理员配置");
            }


            var result = new TableData();
            var objs = UnitWork.Find<SysMessage>(null);
            if (!string.IsNullOrEmpty(request.key))
            {
                objs = objs.Where(u => u.Title.Contains(request.key) || u.Id.Contains(request.key));
            }


            var propertyStr = string.Join(',', properties.Select(u => u.Key));
            result.columnHeaders = properties;
            result.data = objs.OrderBy(u => u.Id)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).Select($"new ({propertyStr})");
            result.count = objs.Count();
            return result;
        }

        public void Add(SysMessage obj)
        {
            Repository.Add(obj);
        }
        
        public void Update(SysMessage obj)
        {
            UnitWork.Update<SysMessage>(u => u.Id == obj.Id, u => new SysMessage
            {
               //todo:要修改的字段赋值
            });

        }

        public SysMessageApp(IUnitWork unitWork, IRepository<SysMessage> repository,
            RevelanceManagerApp app, IAuth auth) : base(unitWork, repository)
        {
            _revelanceApp = app;
            _auth = auth;
        }
    }
}