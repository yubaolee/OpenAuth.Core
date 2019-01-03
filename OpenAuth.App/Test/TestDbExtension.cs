using System;
using Microsoft.Extensions.DependencyInjection;
using NUnit.Framework;

namespace OpenAuth.Repository.Test
{
    class TestDbExtension :TestBase
    {
        
        [Test]
        public void TestGetProperties()
        {
           
            var app = _autofacServiceProvider.GetService<DbExtension>();

            var result = app.GetProperties("Category");
        }
    }
}
