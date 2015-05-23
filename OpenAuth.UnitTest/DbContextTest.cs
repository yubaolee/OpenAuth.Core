using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenAuth.Repository;

namespace OpenAuth.UnitTest
{
    [TestClass]
    public class DbContextTest
    {
        [TestMethod]
        public void TestMethod1()
        {
            Display();
        }

        private void Display()
        {
            OpenAuthDBContext context = new OpenAuthDBContext();
            foreach (var user in context.Users)
            {
                Console.WriteLine(user.RealName);
            }
            foreach (var department in context.Departments)
            {
                Console.WriteLine(department.FullName);
            }
            foreach (var menu in context.Menus)
            {
                Console.WriteLine(menu.FullName);
            }
            foreach (var button in context.Buttons)
            {
                Console.WriteLine(button.FullName);
            }
            foreach (var role in context.Roles)
            {
                Console.WriteLine(role.FullName);
                foreach (var roleMenu in role.RoleMenus)
                {
                    Console.WriteLine(roleMenu.FullName);
                    foreach (var button in roleMenu.Buttons)
                    {
                        Console.WriteLine(button.FullName);
                    }
                }
            }
        }
    }
}
