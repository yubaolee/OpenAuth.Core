using Infrastructure;
using OpenAuth.App.ViewModel;
using OpenAuth.Domain;
using OpenAuth.Domain.Interface;
using System;
using System.Linq;

namespace OpenAuth.App
{
    public class LoginApp
    {
        private IUserRepository _repository;
        private IModuleRepository _moduleRepository;
        private IRelevanceRepository _relevanceRepository;
        private IRepository<ModuleElement> _moduleElementRepository;
        private IResourceRepository _resourceRepository;
        private IOrgRepository _orgRepository;

        public LoginApp(IUserRepository repository,
            IModuleRepository moduleRepository,
            IRelevanceRepository relevanceRepository,
            IRepository<ModuleElement> moduleElementRepository,
            IResourceRepository resourceRepository,
            IOrgRepository orgRepository)
        {
            _repository = repository;
            _moduleRepository = moduleRepository;
            _relevanceRepository = relevanceRepository;
            _moduleElementRepository = moduleElementRepository;
            _resourceRepository = resourceRepository;
            _orgRepository = orgRepository;
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
                        (u.Key == "RoleModule" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();
            //用户角色与自己分配到的菜单ID
            var elementIds =
               _relevanceRepository.Find(
                   u =>
                       (u.FirstId == user.Id && u.Key == "UserElement") ||
                       (u.Key == "RoleElement" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();
            //得出最终用户拥有的模块
            loginVM.Modules = _moduleRepository.Find(u => moduleIds.Contains(u.Id)).OrderBy(u => u.SortNo).MapToList<ModuleView>();

            //模块菜单权限
            foreach (var module in loginVM.Modules)
            {
                module.Elements = _moduleElementRepository.Find(u => u.ModuleId == module.Id && elementIds.Contains(u.Id)).OrderBy(u => u.Sort).ToList();
            }

            //用户角色与自己分配到的资源ID
            var resourceIds = _relevanceRepository.Find(
                    u =>
                        (u.FirstId == user.Id && u.Key == "UserResource") ||
                        (u.Key == "RoleResource" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();
            loginVM.Resources = _resourceRepository.Find(u => resourceIds.Contains(u.Id)).ToList();

            //用户角色与自己分配到的机构ID
            var orgids = _relevanceRepository.Find(
                    u =>
                        (u.FirstId == user.Id && u.Key == "UserAccessedOrg") ||
                        (u.Key == "RoleAccessedOrg" && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();
            loginVM.AccessedOrgs = _orgRepository.Find(u => orgids.Contains(u.Id)).ToList();

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
                    Name = "开发者账号",
                    Account = "System"
                }
            };
            loginUser.Modules = _moduleRepository.Find(null).MapToList<ModuleView>();
            //模块包含的菜单
            foreach (var module in loginUser.Modules)
            {
                module.Elements = _moduleElementRepository.Find(u => u.ModuleId == module.Id).OrderBy(u => u.Sort).ToList();
            }

            loginUser.Resources = _resourceRepository.Find(null).OrderBy(u => u.SortNo).ToList();

            loginUser.AccessedOrgs = _orgRepository.Find(null).OrderBy(u => u.SortNo).ToList();
            return loginUser;
        }
    }
}