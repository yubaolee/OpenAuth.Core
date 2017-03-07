using System;
using System.Configuration;
using System.IO;
using System.Web;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.Mvc.Controllers;

namespace OpenAuth.Mvc.Areas.FlowManage.Controllers
{
    public class FileController : BaseController
    {

        [HttpPost]
        public string Add(HttpPostedFileBase Filedata)
        {
            if (Filedata != null && Filedata.ContentLength > 0 && Filedata.ContentLength < 10485760)
            {
                using (var binaryReader = new BinaryReader(Filedata.InputStream))
                {
                    var fileName = Path.GetFileName(Filedata.FileName);
                    var data = binaryReader.ReadBytes(Filedata.ContentLength);
                    var result = UploadFile(fileName, data, string.Empty);
                    Result.Result = result;
                }
            }
            else
            {
                Result.Message = "文件过大";
                Result.Status = false;
            }

            return JsonHelper.Instance.Serialize(Result);

        }

        private string UploadFile(string fileName, byte[] fileBuffers, string folder)
        {
            if (string.IsNullOrEmpty(folder))
            {
                folder = DateTime.Now.ToString("yyyy_MM_dd");
            }

            //判断文件是否为空
            if (string.IsNullOrEmpty(fileName))
            {
                throw new Exception("文件名不能为空");
            }

            //判断文件是否为空
            if (fileBuffers.Length < 1)
            {
                throw new Exception("文件不能为空");
            }


            var filePath =Server.MapPath("upload");
            var uploadPath = filePath +"\\" + folder + "\\";
            var ext = Path.GetExtension(fileName);
            var newName = Guid.NewGuid().ToString("N") + ext;

            if (!Directory.Exists(uploadPath))
            {
                Directory.CreateDirectory(uploadPath);
            }
            using (var fs = new FileStream(uploadPath + newName, FileMode.Create))
            {
                fs.Write(fileBuffers, 0, fileBuffers.Length);
                fs.Close();
                return  folder + "/" + newName;
            }

        }
    }
}