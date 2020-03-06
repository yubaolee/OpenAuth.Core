// Copyright (c) Brock Allen & Dominick Baier. All rights reserved.
// Licensed under the Apache License, Version 2.0. See LICENSE in the project root for license information.


using System.Collections.Generic;
using System.Security.Claims;
using IdentityModel;
using IdentityServer4.Test;

namespace OpenAuth.IdentityServer.Quickstart
{
    public class TestUsers
    {
        public static List<TestUser> Users = new List<TestUser>
        {
            new TestUser{SubjectId = "System", Username = "System", Password = "123456", 
                Claims = 
                {
                    new Claim(JwtClaimTypes.Name, "System"),
                    new Claim(JwtClaimTypes.GivenName, "yubao"),
                    new Claim(JwtClaimTypes.FamilyName, "lee")}
            }
        };
    }
}