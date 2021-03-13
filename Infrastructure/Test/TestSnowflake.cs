using System;
using System.Collections.Generic;
using NUnit.Framework;
using Yitter.IdGenerator;

namespace Infrastructure.Test
{
    class TestSnowflake
    {
        [Test]
        public void Generate()
        {
            // 全局初始化设置WorkerId，默认最大2^16-1。（初始化过程全局只需一次，且必须最先设置）
            var options = new IdGeneratorOptions(){ WorkerId = 1};
            IIdGenerator IdHelper = new YitIdGenerator(options);
            
            // 初始化以后，就可以在需要的地方调用方法生成ID。
            long val =IdHelper.NewLong();
            int val2 = (int)val;
            
            Console.WriteLine($"val:{val}/int:{val2}");
        }
        
    }


}
