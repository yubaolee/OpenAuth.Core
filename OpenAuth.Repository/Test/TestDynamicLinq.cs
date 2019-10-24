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
    class TestDbContext :TestBase
    {
        [Test]
        public void TestAddUser()
        {
            var dbcontext = _autofacServiceProvider.GetService<OpenAuthDBContext>();
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
        public void TestLoadMenu()
        {
            var dbcontext = _autofacServiceProvider.GetService<OpenAuthDBContext>();
            Stopwatch watch = Stopwatch.StartNew();
            var modules = from module in dbcontext.Modules
                select new
                {
                    Name = module.Name,
                    Elements = dbcontext.ModuleElements.Where(u => u.ModuleId == module.Id)
                };

            Console.WriteLine(JsonHelper.Instance.Serialize(modules));
            watch.Stop();
            Console.WriteLine($"总耗时:{watch.ElapsedMilliseconds}");
        }
        [Test]
        public void TestLoadMenu2()
        {
            var dbcontext = _autofacServiceProvider.GetService<OpenAuthDBContext>();
            Stopwatch watch = Stopwatch.StartNew();
            var modules = from module in dbcontext.Set<Module>().AsNoTracking().AsQueryable()
                          select new
                          {
                              Name = module.Name,
                              Id = module.Id,
                              IconName = module.IconName,
                              Url = module.Url,
                              ParentId = module.ParentId,
                              ParentName = module.ParentName,
                              Elements = dbcontext.Set<ModuleElement>().AsNoTracking().AsQueryable().Where(u => u.ModuleId == module.Id)
                          };

            Console.WriteLine(JsonHelper.Instance.Serialize(modules));
            watch.Stop();
            Console.WriteLine($"总耗时:{watch.ElapsedMilliseconds}");
        }


        //测试独立的repository
        [Test]
        public void TestBaseRepository()
        {
            var account = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            var id = account;

            Console.WriteLine(account);

            var repository = _autofacServiceProvider.GetService<IRepository<User>>();

            //新增
            repository.Add(new User
            {
                Account = account,
                Name = account,
                Password = "000000",
                Id = id
            });

            var user = repository.FindSingle(u => u.Id == id);
            Assert.NotNull(user);

            //修改一个实体
            account = "newuser_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            user.Account = account;
            repository.Update(user);
            var newuser = repository.FindSingle(u => u.Account == account);
            Assert.NotNull(newuser);

            //批量修改
            repository.Update(u => u.Id == id, u =>new User{ Name = account});
            newuser = repository.FindSingle(u => u.Name == account);
            Assert.NotNull(newuser);

            //删除
            repository.Delete(u =>u.Id == id);
            newuser = repository.FindSingle(u => u.Id == id);
            Assert.IsNull(newuser);
        }
    }
}
