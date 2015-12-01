using OpenAuth.Domain.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using Infrastructure;
using Infrastructure.Helper;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;

namespace OpenAuth.App
{
    public class LoginApp
    {
        private IUserRepository _repository;
        private IModuleRepository _moduleRepository;
        private IRelevanceRepository _relevanceRepository;

        public LoginApp(IUserRepository repository,
            IModuleRepository moduleRepository,
            IRelevanceRepository relevanceRepository)
        {
            _repository = repository;
            _moduleRepository = moduleRepository;
            _relevanceRepository = relevanceRepository;
        }

        public LoginUserVM Login(string userName, string password)
        {
            var user = _repository.FindSingle(u => u.Account == userName);
            if (user == null)
            {
                throw new Exception("用户帐号不存在");
            }
            user.CheckPassword(password);

            var loginVM = new LoginUserVM
            {
                User = user
            };
            //用户角色
            var userRoleIds =
                _relevanceRepository.Find(u => u.FirstId == user.Id && u.Key == "UserRole").Select(u => u.SecondId).ToList();

            //用户角色与自己分配到的模块ID
            var moduleIds =
                _relevanceRepository.Find(
                    u =>
                        (u.FirstId == user.Id && u.Key == "UserModule") ||
                        (u.Key == "RoleModule" && userRoleIds.Contains(u.FirstId))).Select(u =>u.SecondId).ToList();
            //得出最终用户拥有的模块
            loginVM.Modules = _moduleRepository.Find(u => moduleIds.Contains(u.Id)).ToList();
            
           return loginVM;
        }

        /// <summary>
        /// 开发者登陆
        /// </summary>
        public LoginUserVM LoginByDev()
        {
            var loginUser = new LoginUserVM
            {
                User = new User
                {
                    Name = "开发者账号"
                }
            };
            loginUser.Modules = _moduleRepository.Find(null).ToList();
            return loginUser;
        }
    }
}