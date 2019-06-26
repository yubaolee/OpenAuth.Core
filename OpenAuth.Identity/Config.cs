using IdentityServer4;
using IdentityServer4.Models;
using System.Collections.Generic;
using System.Security.Claims;
using IdentityModel;

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
        public static IEnumerable<Client> GetClients()
        {
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
                        "http://localhost:52789/swagger/oauth2-redirect.html"
                    },
                    AllowedScopes = { "openauthapi" }
                },
                new Client
                {
                    ClientId = "OpenAuth.Pro",//企业版名称
                    ClientName = "企业版js请求认证",//企业版描述
                    AllowedGrantTypes = GrantTypes.Code,
                    RequirePkce = true,
                    RequireClientSecret = false,

                    RedirectUris =           { "http://localhost:9528/#/oidc-callback" },
                    PostLogoutRedirectUris = { "http://localhost:9528/index.html" },
                    AllowedCorsOrigins =     { "http://localhost:9528" },
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