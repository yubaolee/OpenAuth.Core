using System;
using System.Collections.Generic;
using Infrastructure;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OpenAuth.App;
using OpenAuth.App.Interface;
using OpenAuth.Repository.Domain;

namespace OpenAuth.Mvc.Controllers
{
    /// <summary>  文件上传</summary>
    /// <remarks>   yubaolee, 2019-03-08. </remarks>

    public class FilesController : BaseController
    {

        private FileApp _app;

        public FilesController(IAuth authUtil, FileApp app) : base(authUtil)
        {
            _app = app;
        }

        /// <summary>
        ///  批量上传文件接口
        /// </summary>
        /// <param name="files"></param>
        /// <returns>服务器存储的文件信息</returns>
        [HttpPost]
        public Response<IList<UploadFile>> Upload(IFormFileCollection files)
        {
            var result = new Response<IList<UploadFile>>();
            try
            {
                result.Result = _app.Add(files);
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }

            return result;
        }
    }
}
