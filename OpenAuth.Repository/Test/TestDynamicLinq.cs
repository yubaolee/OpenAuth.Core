using System;
using System.Diagnostics;
using System.Linq;
using Infrastructure;
using Microsoft.EntityFrameworkCore;
using NUnit.Framework;
using OpenAuth.Repository.Domain;
using Microsoft.Extensions.DependencyInjection;
using OpenAuth.Repository.Interface;

namespace OpenAuth.Repository.Test
{
    class TestDynamicLinq :TestBase
    {
        [Test]
        public void GenerateFilter()
        {
            var dbcontext = _autofacServiceProvider.GetService<OpenAuthDBContext>();
            var json = @"
{
	""Operation"": ""and"",
                ""Filters"": [{
                ""Key"": ""Name"",
                ""Contrast"": ""=="",
                ""Value"": ""admin""

        },
        {
            ""Key"": ""Name"",
                ""Contrast"": ""=="",
                ""Value"": ""admin""
        }
        ],
        ""Children"": [{
        ""Operation"": ""or"",
        ""Filters"": [{
        ""Key"": ""Name"",
        ""Contrast"": ""=="",
        ""Value"": ""admin""
    },
    {
    ""Key"": ""Name"",
    ""Contrast"": ""=="",
    ""Value"": ""admin""
    }
    ],
    ""Children"": [


    ]
}

]
}
";
            Filter[] filter = {new Filter
            {
                Key = "Name",
                Contrast = "==",
                Value = "admin"
            }};
            var query = dbcontext.Users.GenerateFilter(json);
            // Console.WriteLine(query.ToString());
            
            Console.WriteLine(JsonHelper.Instance.Serialize(query.ToList()));
        }
        
        [Test]
        public void TestDynamic()
        {
            var dbcontext = _autofacServiceProvider.GetService<OpenAuthDBContext>();
//            var query = dbcontext.Users.Where("Name=='admin' && Sex==0");
//            query = query.OrderBy(u => u.Id)
//                .Skip(0)
//                .Take(10);
//            
//            Console.WriteLine(JsonHelper.Instance.Serialize(query.ToList()));
        }
        
    }
}
