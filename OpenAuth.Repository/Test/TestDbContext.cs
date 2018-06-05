using System;
using System.Linq;
using NUnit.Framework;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Repository.Test
{
    class TestDbContext
    {
        [Test]
        public void TestAddUser()
        {
            var dbcontext = new OpenAuthDBContext();
            int count = dbcontext.Users.Count();
            Console.WriteLine($"添加前用户数：{count}");
            var account = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            Console.WriteLine(account);

            dbcontext.Users.Add(new User
            {
                Account = account,
                Name = account,
                BizCode = "",
                Password = "000000"
                ,CreateTime = DateTime.Now
                ,Id=Guid.NewGuid().ToString()
            });
            dbcontext.SaveChanges();
            Assert.True(dbcontext.Users.Any(u => u.Account == account));

            int aftercount = dbcontext.Users.Count();
            Assert.AreEqual(aftercount, count + 1);
        }
    }
}
