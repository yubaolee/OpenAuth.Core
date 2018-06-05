using System;
using System.Security.Cryptography;
using System.Text;

namespace Infrastructure
{
    public class Md5
    {
        public static string Encrypt(string str)
        {

            string pwd = String.Empty;

            MD5 md5 = MD5.Create();

            // 编码UTF8/Unicode　
            byte[] s = md5.ComputeHash(Encoding.UTF8.GetBytes(str));

            // 转换成字符串
            for (int i = 0; i < s.Length; i++)
            {
                //格式后的字符是小写的字母
                //如果使用大写（X）则格式后的字符是大写字符
                pwd = pwd + s[i].ToString("X");

            }

            return pwd;
        }
    }
}
