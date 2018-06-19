using System;
using System.Collections.Generic;
using System.Text;
using Autofac.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection;
using NUnit.Framework;
using OpenAuth.App.Response;

namespace OpenAuth.App.Test
{
    class TestUserApp :TestBase
    {
        
        [Test]
        public void TestAdd()
        {
            var account = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            Console.WriteLine(account);
            var app = _autofacServiceProvider.GetService<UserManagerApp>();

            var newuser = new UserView
            {
                Account = account,
                Name = account,
                OrganizationIds = "08f41bf6-4388-4b1e-bd3e-2ff538b44b1b,543a9fcf-4770-4fd9-865f-030e562be238",
                Organizations = "研发小组,集团总部"
            };
            app.AddOrUpdate(newuser);

            app.AddOrUpdate(new UserView
            {
                Id = newuser.Id,
                Account = account,
                Name = "新名字",
                OrganizationIds = "08f41bf6-4388-4b1e-bd3e-2ff538b44b1b",
                Organizations = "研发小组"
            });
        }
    }
}
