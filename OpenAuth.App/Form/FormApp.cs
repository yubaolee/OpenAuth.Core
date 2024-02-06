using System;
using System.Linq;
using System.Threading.Tasks;
using Infrastructure;
using Infrastructure.Utilities;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using OpenAuth.App.Interface;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;


namespace OpenAuth.App
{
    public class FormApp : BaseStringApp<Form,OpenAuthDBContext>
    {
        private IOptions<AppSetting> _appConfiguration;
        private IHttpContextAccessor _httpContextAccessor;
        /// <summary>
        /// 加载列表
        /// </summary>
        public async Task<TableData> Load(QueryFormListReq request)
        {
            var result = new TableData();
            var forms = GetDataPrivilege("u");
            if (!string.IsNullOrEmpty(request.key))
            {
                forms = forms.Where(u => u.Name.Contains(request.key) || u.Id.Contains(request.key));
            }

            result.data = forms.OrderByDescending(u => u.CreateDate)
                .Skip((request.page - 1) * request.limit)
                .Take(request.limit).ToList();
            result.count = await forms.CountAsync();
            return result;
        }

        public void Add(Form obj)
        {
            var user = _auth.GetCurrentUser().User;
            obj.CreateUserId = user.Id;
            obj.CreateUserName = user.Name;
            UnitWork.Add(obj);
            if (!string.IsNullOrEmpty(obj.DbName))
            {
                var dbtype = _appConfiguration.Value.DbTypes[_httpContextAccessor.GetTenantId()];
                
                UnitWork.ExecuteSql(FormFactory.CreateForm(obj, this.UnitWork).GetSql(obj, dbtype));
            }
            UnitWork.Save();
        }

        public void Update(Form obj)
        {
            Repository.Update(u => u.Id == obj.Id, u => new Form
            {
                ContentData = obj.ContentData,
                Content = obj.Content,
                ContentParse = obj.ContentParse,
                Name = obj.Name,
                Disabled = obj.Disabled,
                DbName = obj.DbName,
                SortCode = obj.SortCode,
                Description = obj.Description,
                OrgId =  obj.OrgId,
                ModifyDate = DateTime.Now
            });

            if (!string.IsNullOrEmpty(obj.DbName))
            {
                var dbtype = _appConfiguration.Value.DbTypes[_httpContextAccessor.GetTenantId()];
                UnitWork.ExecuteSql(FormFactory.CreateForm(obj,this.UnitWork).GetSql(obj, dbtype));
            }
        }

        public FormResp FindSingle(string id)
        {
            var form = Get(id);
            return form.MapTo<FormResp>();
        }

        public FormApp(IUnitWork<OpenAuthDBContext> unitWork, IRepository<Form,OpenAuthDBContext> repository,
            IAuth auth, IOptions<AppSetting> appConfiguration, IHttpContextAccessor httpContextAccessor) : base(unitWork, repository, auth)
        {
            _auth = auth;
            _appConfiguration = appConfiguration;
            _httpContextAccessor = httpContextAccessor;
        }
    }
}