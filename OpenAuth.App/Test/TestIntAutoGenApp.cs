using System;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Test
{
    public class TestIntAutoGenApp :TestBase
    {

        [Test]
        public void Add()
        {
            var app = _autofacServiceProvider.GetService<IntAutoGenApp>();
            var intAutoGen = new IntAutoGen
            {
                Name = DateTime.Now.ToString()
            };
            app.Add(intAutoGen);
            Console.WriteLine($"new Id:{intAutoGen.Id}");
        }

        [Test]
        public void Del()
        {
            var app = _autofacServiceProvider.GetService<IntAutoGenApp>();
            app.Delete(new []{1, 2});
        }
        
    }
}
