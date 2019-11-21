using System;
using System.Linq.Expressions;
using NUnit.Framework;

namespace Infrastructure.Test
{
    public class TestDynamicLinq
    {
        [Test]
        public void Convert()
        {
            FilterGroup sub = new FilterGroup
            {
                Operation = "or"
            };
            sub.Filters = new[]
            {
                new Filter {Key = "name", Value = "name", Contrast = "=="},
                new Filter {Key = "c3", Value = "10,20,30", Contrast = "in"}
            };
            
            FilterGroup filterGroup = new FilterGroup
            {
                Operation = "and"
            };
            filterGroup.Filters = new[]
            {
                new Filter {Key = "c1", Value = "name", Contrast = "contains"},
                new Filter {Key = "10,20,30", Value = "40", Contrast = "intersect"}
            };

            filterGroup.Children = new[]
            {
                sub
            };

            var expression = DynamicLinq.ConvertGroup<TestOjb>(filterGroup,
                Expression.Parameter(typeof(TestOjb), "c"));
            
            Console.WriteLine(expression.ToString());
            
        }
    }
    
    public class TestOjb{
    public string c1 { get; set; }
    public string c2 { get; set; }
    public string c3 { get; set; }
    public string c4 { get; set; }
    public string c5 { get; set; }
    public string c6 { get; set; }
    public string c7 { get; set; }
    }
}