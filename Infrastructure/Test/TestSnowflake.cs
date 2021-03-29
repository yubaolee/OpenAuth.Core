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
            var options = new IdGeneratorOptions()
            {
                Method = 1,
                WorkerId = 1
            };
            
            YitIdHelper.SetIdGenerator(options);
            long newId = YitIdHelper.NextId();
            Console.WriteLine("=====================================");
            Console.WriteLine("生成的 Id：" + newId);
        }
        
    }


}
