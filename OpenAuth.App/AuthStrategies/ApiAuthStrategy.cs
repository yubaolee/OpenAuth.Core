// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : 李玉宝
// Created          : 07-05-2018
//
// Last Modified By : 李玉宝
// Last Modified On : 07-05-2018
// ***********************************************************************
// <copyright file="ApiAuthStrategy.cs" company="OpenAuth.App">
//     Copyright (c) http://www.openauth.me. All rights reserved.
// </copyright>
// <summary>
// MVC的请求策略
// </summary>
// ***********************************************************************


using Infrastructure;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;
using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenAuth.App
{
    /// <summary>
    /// MVC的请求策略
    /// </summary>
    public class ApiAuthStrategy : NormalAuthStrategy
    {
        private IOptions<AppSetting> _appConfiguration;
        private HttpHelper _helper;
        private IHttpContextAccessor _httpContextAccessor;

        public ApiAuthStrategy(IUnitWork unitWork, IRepository<User> repository
            , IHttpContextAccessor httpContextAccessor, IOptions<AppSetting> appConfiguration) : base(unitWork, repository)
        {
            _httpContextAccessor = httpContextAccessor;
            _appConfiguration = appConfiguration;
            _helper = new HttpHelper(_appConfiguration.Value.SSOPassport);


        }

        private string GetToken()
        {
            string token = _httpContextAccessor.HttpContext.Request.Query["Token"];
            if (!String.IsNullOrEmpty(token)) return token;

            var cookie = _httpContextAccessor.HttpContext.Request.Cookies["Token"];
            return cookie ?? String.Empty;
        }

        public override IQueryable<Org> GetOrgsQuery()
        {
            var requestUri = String.Format("/api/Check/GetOrgs?token={0}&requestid={1}", GetToken(), "");

            var value = _helper.Get(null, requestUri);
            var result = JsonHelper.Instance.Deserialize<Response<List<Org>>>(value);
            if (result.Code == 200)
            {
                return result.Result.AsQueryable();
            }

            return null;
        }

        public override IQueryable<Resource> GetResourcesQuery()
        {
            var requestUri = String.Format("/api/Check/GetResources?token={0}&requestid={1}", GetToken(), "");

            var value = _helper.Get(null, requestUri);
            var result = JsonHelper.Instance.Deserialize<Response<List<Resource>>>(value);
            if (result.Code == 200)
            {
                return result.Result.AsQueryable();
            }

            return null;
        }

        public override List<ModuleView> GetModulesQuery()
        {
            var requestUri = String.Format("/api/Check/GetModules?token={0}&requestid={1}", GetToken(), "");

            var value = _helper.Get(null, requestUri);
            var result = JsonHelper.Instance.Deserialize<Response<List<ModuleView>>>(value);
            if (result.Code == 200)
            {
                return result.Result;
            }

            return null;
        }

        public override IQueryable<Role> GetRolesQuery()
        {
            var requestUri = String.Format("/api/Check/GetRoles?token={0}&requestid={1}", GetToken(), "");

            var value = _helper.Get(null, requestUri);
            var result = JsonHelper.Instance.Deserialize<Response<List<Role>>>(value);
            if (result.Code == 200)
            {
                return result.Result.AsQueryable();
            }

            return null;
        }
    }
}