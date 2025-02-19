﻿using System;
using System.Linq;
using Infrastructure;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using OpenAuth.Repository.Domain;
using SqlSugar;

namespace OpenAuth.Repository.Test
{
    class TestSugarDynamicLinq : TestBase
    {
        [Test]
        public void GenerateFilter()
        {
            var sugarClient = _autofacServiceProvider.GetService<ISqlSugarClient>();
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

            var query = sugarClient.Queryable<SysUser>().GenerateFilter("c",json);
            Console.WriteLine(query.ToSqlString());

            Console.WriteLine(JsonHelper.Instance.Serialize(query.ToList()));
        }

        [Test]
        public void TestGetColumns()
        {
            var sugarClient = _autofacServiceProvider.GetService<ISqlSugarClient>();

            var tables = sugarClient.DbMaintenance.GetTableInfoList();
            // Console.WriteLine(JsonHelper.Instance.Serialize(tables));

            var query = sugarClient.DbMaintenance.GetColumnInfosByTableName("userv");
            Console.WriteLine(JsonHelper.Instance.Serialize(query));
        }

        [Test]
        public void TestDynamic()
        {
            QueryObject sub = new QueryObject
            {
                Operation = "or"
            };
            sub.Filters = new[]
            {
                new Filter {Key = "Name", Value = "name", Contrast = "=="},
                new Filter {Key = "Sex", Value = "10", Contrast = "=="}
            };

            QueryObject queryObject = new QueryObject
            {
                Operation = "and"
            };
            queryObject.Filters = new[]
            {
                new Filter {Key = "Account", Value = "name", Contrast = "=="},
                new Filter {Key = "Password", Value = "10", Contrast = "=="}
            };

            queryObject.Children = new[]
            {
                sub
            };

            var sugarClient = _autofacServiceProvider.GetService<ISqlSugarClient>();

            var query = sugarClient.Queryable<SysUser>().GenerateFilter("c",queryObject);
            Console.WriteLine(query.ToSqlString());
        }
    }
}