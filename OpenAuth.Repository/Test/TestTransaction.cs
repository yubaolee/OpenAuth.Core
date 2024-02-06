﻿using System;
using System.Linq;
using NUnit.Framework;
using Microsoft.Extensions.DependencyInjection;
using OpenAuth.Repository.Domain;
using OpenAuth.Repository.Interface;

namespace OpenAuth.Repository.Test
{
    /// <summary>
    /// 测试事务
    /// </summary>
    class TestTransaction : TestBase
    {
        /// <summary>
        /// 测试事务正常提交
        /// </summary>
        [Test]
        public void NormalSubmit()
        {
            var unitWork = _autofacServiceProvider.GetService<IUnitWork<OpenAuthDBContext>>();
            unitWork.ExecuteWithTransaction(() =>
            {
                var account = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");

                AddAndUpdate(account, unitWork);
            });

        }

        /// <summary>
        /// 测试事务回滚
        /// </summary>
        [Test]
        public void SubmitWithRollback()
        {
            var unitWork = _autofacServiceProvider.GetService<IUnitWork<OpenAuthDBContext>>();
            var account = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
            try
            {
                unitWork.ExecuteWithTransaction(() =>
                {
                    AddAndUpdate(account, unitWork);

                    throw new Exception("模拟异常");
                });
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            
            //如果没有插入成功，表示事务发生了回滚
            Assert.IsFalse(unitWork.Any<User>( u=>u.Id == account));

        }

        /// <summary>
        /// 测试添加，单个修改，Z.EntityFramework.Plus条件修改
        /// </summary>
        private void AddAndUpdate(string account, IUnitWork<OpenAuthDBContext> unitWork)
        {
            var user = new User
            {
                Id = account,
                Account = account,
                Name = account,
            };

            unitWork.Add(user);

            unitWork.Save();


            user.Account = "Trans_" + user.Account;
            user.Name = "Trans_" + user.Name;
            unitWork.Update(user);

            unitWork.Save();

            unitWork.Update<User>(u => u.Id == account, u => new User
            {
                Account = "Trans2_" + user.Account
            });
        }


        [Test]
        public void MultiUpdate()
        {
            var unitWork = _autofacServiceProvider.GetService<IUnitWork<OpenAuthDBContext>>();

            var users = unitWork.Find<User>(u => u.Account.Contains("test"));
            foreach (var user in users)
            {
                user.Name  = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss");
                unitWork.Update(user);
            }
            
            unitWork.Save();
            
        }

        [Test]
        public void MultiUpdate2()
        {
            var unitWork = _autofacServiceProvider.GetService<IUnitWork<OpenAuthDBContext>>();
            var users = unitWork.Find<User>(null).ToList();
            unitWork.ExecuteWithTransaction(()=>
            {
                foreach (var req in users)
                {
                    unitWork.Update<User>(u =>u.Id == req.Id, user => new User
                    {
                        Name  = "user_" + DateTime.Now.ToString("yyyy_MM_dd HH:mm:ss")
                    });
                    

                    unitWork.Update<SysOrg>(u => u.Id == "08f41bf6-4388-4b1e-bd3e-2ff538b44b1b", u => new SysOrg
                    {
                       CreateTime = DateTime.Now
                    });
                }

                unitWork.Save();
            });

        }
    }
}