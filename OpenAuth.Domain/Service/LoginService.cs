using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenAuth.Domain.Interface;
using OpenAuth.Domain.Model;

namespace OpenAuth.Domain.Service
{
    public class LoginService
    {
        private IUserRepository _userRepository;

        public LoginService(IUserRepository repository)
        {
            _userRepository = repository;
        }

        public User Login(string username, string password)
        {
            return _userRepository.FindBy(username);
           
        }

    }
}
