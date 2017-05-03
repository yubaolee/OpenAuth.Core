// ***********************************************************************
// Assembly         : OpenAuth.Domain
// Author           : yubaolee
// Created          : 05-27-2016
//
// Last Modified By : yubaolee
// Last Modified On : 05-27-2016
// Contact : Microsoft
// File: ModuleManService.cs
// ***********************************************************************

using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.Domain.Interface;

namespace OpenAuth.Domain.Service
{
    /// <summary>
    /// 领域服务
    /// <para>模块领域服务</para>
    /// </summary>
    public class ModuleManService
    {
        private readonly IModuleRepository _repository;
        private readonly IRelevanceRepository _relevanceRepository;
        private readonly AuthoriseFactory _factory;

        public ModuleManService(IModuleRepository repository,
            IRelevanceRepository relevanceRepository, AuthoriseFactory authoriseService)
        {
            _repository = repository;
            _relevanceRepository = relevanceRepository;
            _factory = authoriseService;
        }

        /// <summary>
        /// 加载一个节点下面的所有
        /// </summary>
        public dynamic Load(string loginuser, Guid parentId, int pageindex, int pagesize)
        {

            var service= _factory.Create(loginuser);
            if (!service.GetModulesQuery().Any()) //用户不能访问任何模块
            {
                return new
                {
                    total = 0,
                    records = 0,
                    page = pageindex
                };
            }
            var ids = GetSubIds(parentId);
            var query = service.GetModulesQuery().Where(u => parentId == Guid.Empty || (u.ParentId != null&&ids.Contains(u.ParentId.Value)));

            int total = query.Count();
            var modules = query.OrderBy(u=>u.CascadeId).Skip((pageindex - 1)*pagesize).Take(pagesize);

            return new
            {
                records = total,
                total = Math.Ceiling((double)total/pagesize),
                rows = modules,
                page = pageindex
            };
        }

        public void Delete(Guid id)
        {
            var del = _repository.FindSingle(u => u.Id == id);
            if (del == null) return;

            _repository.Delete(u => u.CascadeId.Contains(del.CascadeId));
        }

        public void AddOrUpdate(Module model)
        {
            ChangeModuleCascade(model);
            if (model.Id == Guid.Empty)
            {
                _repository.Add(model);
            }
            else
            {
                //获取旧的的CascadeId
                var CascadeId = _repository.FindSingle(o => o.Id == model.Id).CascadeId;
                //根据CascadeId查询子部门
                var models = _repository.Find(u => u.CascadeId.Contains(CascadeId) && u.Id != model.Id).OrderBy(u => u.CascadeId).ToList();

                _repository.Update(model);

                //更新子部门的CascadeId
                foreach (var a in models)
                {
                    ChangeModuleCascade(a);
                    _repository.Update(a);
                }
            }
        }

        #region 用户/角色分配模块

        /// <summary>
        /// 加载特定用户的模块
        /// </summary>
        /// <param name="userId">The user unique identifier.</param>
        public List<Module> LoadForUser(Guid userId)
        {
            //用户角色
            var userRoleIds =
                _relevanceRepository.Find(u => u.FirstId == userId && u.Key == "UserRole").Select(u => u.SecondId).ToList();

            //用户角色与自己分配到的模块ID
            var moduleIds =
                _relevanceRepository.Find(
                    u =>
                        (u.FirstId == userId && u.Key == "UserModule") ||
                        (u.Key == "RoleModule" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();

            //var moduleIds =
            //    _relevanceRepository.Find(u => u.FirstId == userId && u.Key == "UserModule")
            //        .Select(u => u.SecondId)
            //        .ToList();
            if (!moduleIds.Any()) return new List<Module>();
            return _repository.Find(u => moduleIds.Contains(u.Id)).ToList();
        }

        /// <summary>
        /// 加载特定角色的模块
        /// </summary>
        /// <param name="roleId">The role unique identifier.</param>
        public List<Module> LoadForRole(Guid roleId)
        {
            var moduleIds =
                _relevanceRepository.Find(u => u.FirstId == roleId && u.Key == "RoleModule")
                    .Select(u => u.SecondId)
                    .ToList();
            if (!moduleIds.Any()) return new List<Module>();
            return _repository.Find(u => moduleIds.Contains(u.Id)).ToList();
        }

        #endregion 用户/角色分配模块

        #region 私有方法

        //根据同一级中最大的语义ID

        private Guid[] GetSubIds(Guid parentId)
        {
            if (parentId == Guid.Empty) return _repository.Find(null).Select(u => u.Id).ToArray();
            var parent = _repository.FindSingle(u => u.Id == parentId);
            var orgs = _repository.Find(u => u.CascadeId.Contains(parent.CascadeId)).Select(u => u.Id).ToArray();
            return orgs;
        }

        //修改对象的级联ID
        private void ChangeModuleCascade(Module module)
        {
            string cascadeId;
            int currentCascadeId = 1;  //当前结点的级联节点最后一位
            var sameLevels = _repository.Find(o => o.ParentId == module.ParentId && o.Id != module.Id);
            foreach (var obj in sameLevels)
            {
                int objCascadeId = int.Parse(obj.CascadeId.TrimEnd('.').Split('.').Last());
                if (currentCascadeId <= objCascadeId) currentCascadeId = objCascadeId + 1;
            }

            if (module.ParentId != null && module.ParentId != Guid.Empty)
            {
                var parentOrg = _repository.FindSingle(o => o.Id == module.ParentId);
                if (parentOrg != null)
                {
                    cascadeId = parentOrg.CascadeId + currentCascadeId +".";
                    module.ParentName = parentOrg.Name;
                }
                else
                {
                    throw new Exception("未能找到该组织的父节点信息");
                }
            }
            else
            {
                cascadeId = ".0." + currentCascadeId +".";
                module.ParentName = "根节点";
            }

            module.CascadeId = cascadeId;
        }

        #endregion 私有方法
    }
}