// Copyright (c) Brock Allen & Dominick Baier. All rights reserved.
// Licensed under the Apache License, Version 2.0. See LICENSE in the project root for license information.


using System.Collections.Generic;
using System.Security.Claims;
using IdentityModel;
using IdentityServer4;
using IdentityServer4.Models;

namespace OpenAuth.IdentityServer
{
     public static class Config
    {
        public static IEnumerable<IdentityResource> GetIdentityResources()
        {
            return new IdentityResource[]
            {
                new IdentityResources.OpenId(),
                new IdentityResources.Profile(),
            };
        }
        /// <summary>
        /// API信息
        /// </summary>
        /// <returns></returns>
        public static IEnumerable<ApiResource> GetApis()
        {
            return new[]
            {
                new ApiResource("openauthapi", "OpenAuth.WebApi")
                {
                    UserClaims =  { ClaimTypes.Name, JwtClaimTypes.Name }
                }
            };
        }
        /// <summary>
        /// 客户端信息
        /// </summary>
        /// <returns></returns>
        public static IEnumerable<Client> GetClients(bool isProduction)
        {
            var host = "http://localhost";
            if (isProduction)
            {
                host = "http://demo.openauth.me";  //切换为自己的服务器信息
            }
            return new[]
            {
                new Client
                {
                    ClientId = "OpenAuth.WebApi",//客户端名称
                    ClientName = "开源版webapi认证",//客户端描述
                    AllowedGrantTypes = GrantTypes.Implicit,//Implicit 方式
                    AllowAccessTokensViaBrowser = true,//是否通过浏览器为此客户端传输访问令牌
                    RedirectUris =
                    {
                        $"{host}:52789/swagger/oauth2-redirect.html"
                    },
                    AllowedScopes = { "openauthapi" }
                },
                new Client
                {
                    ClientId = "OpenAuth.Mvc",
                    ClientName = "开源版mvc认证",
                    AllowedGrantTypes = GrantTypes.Implicit,

                    // 登录成功回调处理地址，处理回调返回的数据
                    RedirectUris = { $"{host}:1802/signin-oidc" },

                    // where to redirect to after logout
                    PostLogoutRedirectUris = { $"{host}:1802/signout-callback-oidc" },

                    AllowedScopes = new List<string>
                    {
                        IdentityServerConstants.StandardScopes.OpenId,
                        IdentityServerConstants.StandardScopes.Profile,
                        "openauthapi"
                    }
                },
                new Client
                {
                    ClientId = "OpenAuth.Pro",//企业版名称
                    ClientName = "企业版js请求认证",//企业版描述
                    AllowedGrantTypes = GrantTypes.Code,
                    RequirePkce = true,
                    RequireClientSecret = false,

                    RedirectUris =           { $"{host}:1803/#/oidc-callback" },
                    PostLogoutRedirectUris = { $"{host}:1803" },
                    AllowedCorsOrigins =     { $"{host}:1803" },
                    AllowedScopes =
                    {
                        IdentityServerConstants.StandardScopes.OpenId,
                        IdentityServerConstants.StandardScopes.Profile,  //请求用户的姓名，昵称等
                        "openauthapi"
                    }
                }
            };
        }
    }
}