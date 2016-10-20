// ***********************************************************************
// Assembly         : OpenAuth.Domain
// Author           : yubaolee
// Created          : 05-27-2016
//
// Last Modified By : yubaolee
// Last Modified On : 05-27-2016
// Contact : Microsoft
// File: ModuleEleManService.cs
// ***********************************************************************


using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Domain.Service
{
    /// <summary>
    /// 领域服务
    /// <para>模块菜单管理服务</para>
    /// </summary>
    public class ModuleEleManService
    {
        private readonly IUnitWork _unitWork;
        private readonly AuthoriseFactory _factory;

        public ModuleEleManService(IUnitWork unitWork, AuthoriseFactory authoriseService)
        {
            _unitWork = unitWork;
            _factory = authoriseService;
        }

        public void AddOrUpdate(ModuleElement model)
        {
            if (model.Id == Guid.Empty)
            {
                _unitWork.Add(model);
            }
            else
            {
                _unitWork.Update(model);
            }

            _unitWork.Save();
        }

        public IEnumerable<ModuleElement> LoadByModuleId(string loginuser, Guid id)
        {
            var service = _factory.Create(loginuser);
            if (!service.GetModuleElementsQuery().Any()) //用户没有任何资源
            {
                return new List<ModuleElement>();
            }

            var modules = service.GetModuleElementsQuery().Where(u => u.ModuleId == id).OrderBy(u =>u.Sort);
            return modules;
        }

        /// <summary>
        /// 获取带有授权状态的菜单列表
        /// </summary>
        /// <param name="username">当前登录的操作人</param>
        /// <param name="accessType">授权类型，当前有RoleElement/UserElement</param>
        /// <param name="firstId">
        /// 当为RoleElement时，表示RoleId
        /// 当为UserElement时，表示UserId
        /// </param>
        /// <param name="moduleId">模块ID</param>
        public List<dynamic> LoadWithAccess(string username, string accessType, Guid firstId, Guid moduleId)
        {
            var listVms = new List<dynamic>();
            var service = _factory.Create(username);
            if (!service.GetModuleElementsQuery().Any()) //用户没有任何资源
            {
               return listVms;
            }
            if (moduleId == Guid.Empty) return listVms;
            foreach (var element in service.GetModuleElementsQuery().Where(u =>u.ModuleId ==moduleId))
            {
                var accessed = _unitWork.FindSingle<Relevance>(u =>u.Key == accessType 
                    && u.FirstId == firstId && u.SecondId == element.Id);
                var vm = new 
                {
                    Id = element.Id,
                    Name = element.Name,
                    ModuleId = element.ModuleId,
                    DomId = element.DomId,
                    Checked = accessed != null
                };
                listVms.Add(vm);
            }
            return listVms;
        }

        public void Delete(Guid[] objs)
        {
            _unitWork.Delete<ModuleElement>(u =>objs.Contains(u.Id));
        }
    }
}
