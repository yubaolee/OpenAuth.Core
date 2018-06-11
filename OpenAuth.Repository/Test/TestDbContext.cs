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
                Password = "000000"
                ,Id=Guid.NewGuid().ToString()
            });
            dbcontext.SaveChanges();
            Assert.True(dbcontext.Users.Any(u => u.Account == account));

            int aftercount = dbcontext.Users.Count();
            Assert.AreEqual(aftercount, count + 1);
        }

        //测试独立的repository
        [Test]
        public void TestBaseRepository()
        {
            var account = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            var id = account;

            Console.WriteLine(account);

            //新增
            new BaseRepository<User>().Add(new User
            {
                Account = account,
                Name = account,
                Password = "000000",
                Id = id
            });

            var user = new BaseRepository<User>().FindSingle(u => u.Id == id);
            Assert.NotNull(user);

            //修改一个实体
            account = "newuser_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            user.Account = account;
            new BaseRepository<User>().Update(user);
            var newuser = new BaseRepository<User>().FindSingle(u => u.Account == account);
            Assert.NotNull(newuser);

            //批量修改
            new BaseRepository<User>().Update(u => u.Id == id, u =>new User{ Name = account});
            newuser = new BaseRepository<User>().FindSingle(u => u.Name == account);
            Assert.NotNull(newuser);

            //删除
            new BaseRepository<User>().Delete(u =>u.Id == id);
            newuser = new BaseRepository<User>().FindSingle(u => u.Id == id);
            Assert.IsNull(newuser);
        }
    }
}
