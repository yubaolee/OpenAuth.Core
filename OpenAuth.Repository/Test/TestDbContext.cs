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

        [Test]
        public void TestBaseRepository()
        {
            var repository = new BaseRepository<User>();
            var account = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            repository.Add(new User
            {
                Account = account,
                Name = account,
                Password = "000000"
                ,
                Id = account
            });

            var user = repository.FindSingle(u => u.Id == account);
            Assert.NotNull(user);

            account = "newuser_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            user.Account = account;
            repository.Update(user);

            var newuser = repository.FindSingle(u => u.Id == account);
            Assert.AreEqual(newuser.Account, account);

            repository.Update(u => u.Account == account, u =>new User{ Name = account});
            newuser = repository.FindSingle(u => u.Account == account);
            Assert.AreEqual(newuser.Name, account);

        }
    }
}
