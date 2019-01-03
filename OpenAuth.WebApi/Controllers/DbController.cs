using System;
using System.Collections.Generic;
using Infrastructure;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;

namespace OpenAuth.WebApi.Controllers
{
    /// <summary>
    /// 数据库信息相关操作
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController] 
    public class DbController : ControllerBase
    {
        private DbExtension _dbExtension;

        public DbController(DbExtension dbExtension)
        {
            _dbExtension = dbExtension;
        }
        /// <summary>
        /// 获取模块的所有字段，用于分配用户可见字段
        /// </summary>
        /// <param name="moduleName">如User/Module</param>
        /// <returns></returns>
        [HttpGet]
        public Response<List<KeyDescription>> GetProperties(string moduleName)
        {
            var result = new Response<List<KeyDescription>>();
            try
            {
                result.Result = _dbExtension.GetProperties(moduleName);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.InnerException?.Message ?? ex.Message;
            }

            return result;
        }
    }
}
