using System;
using System.Linq;
using System.Security.Cryptography;
using OpenAuth.App.DTO;
using OpenAuth.Domain.Interface;
using OpenAuth.Domain.Service;

namespace OpenAuth.App
{
    public class LoginApp
    {
        private LoginService _loginService;

        public LoginApp(LoginService service)
        {
            _loginService = service;
        }

        public LoginResponse Login(LoginRequest request)
        {
            var resp = new LoginResponse {UserName = request.UserName};

            try
            {
                var user = _loginService.Login(request.UserName, request.Password);
                resp.UserId = user.Id;
                resp.Success = true;
            }
            catch (Exception ex)
            {
                resp.Success = false;
                resp.Message = ex.Message;
            }
           
            return resp;
        }
    }
}