using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Text;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Infrastructure.Test
{
    [TestClass]
    class TestAutoMapper
    {
        [TestMethod]
        public void TestConvert()
        {
            var my = new MyClass
            {
                Name = "yubao"
            };

            var dest = my.MapTo<DestClass>();
        }
    }


    class MyClass
    {
        public string Name { get; set; }
        public string NickName { get; set; }
    }

    class DestClass
    {
        public string Name { get; set; }
        public int Age { get; set; }
    }
}
