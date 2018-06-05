using System.Security.Cryptography;
using System.Text;

namespace Infrastructure
{
    public static class StringExtensions
    {
        public static string MaxSubstring(this string origin, int maxLength)
        {
            return origin.Length >= maxLength ? origin.Substring(0, maxLength) : origin;
        }

        public static string ToMd5(this string origin)
        {
            if (string.IsNullOrWhiteSpace(origin))
            {
                return string.Empty;
            }

            var md5Algorithm = MD5.Create();
            var utf8Bytes = Encoding.UTF8.GetBytes(origin);
            var md5Hash = md5Algorithm.ComputeHash(utf8Bytes);
            var hexString = new StringBuilder();
            foreach (var hexByte in md5Hash)
            {
                hexString.Append(hexByte.ToString("x2"));
            }
            return hexString.ToString();
        }
    }
}