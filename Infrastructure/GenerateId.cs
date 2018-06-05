// ***********************************************************************
// Assembly         : FairUtility
// Author           : Yubao Li
// Created          : 10-13-2015
//
// Last Modified By : Yubao Li
// Last Modified On : 10-13-2015
// ***********************************************************************
// <copyright file="GenerateId.cs" company="">
//     Copyright (c) . All rights reserved.
// </copyright>
// <summary>创建唯一ID</summary>
// ***********************************************************************

using System;
using System.Security.Cryptography;

namespace Infrastructure
{
    public class GenerateId
    {
        public static string GetGuidHash()
        {
            return Guid.NewGuid().ToString().GetHashCode().ToString("x");
        }

        /// <summary>
        /// 生成一个长整型，可以转成19字节长的字符串
        /// </summary>
        /// <returns>System.Int64.</returns>
        public static long GenerateLong()
        {
            byte[] buffer = Guid.NewGuid().ToByteArray();
            return BitConverter.ToInt64(buffer, 0);
        }

        /// <summary>
        /// 生成16个字节长度的数据与英文组合串
        /// </summary>
        public static string GenerateStr()
        {
            long i = 1;

            foreach (byte b in Guid.NewGuid().ToByteArray())
            {
                i *= ((int)b + 1);
            }

            return String.Format("{0:x}", i - DateTime.Now.Ticks);
        }

        /// <summary>
        /// 创建11位的英文与数字组合
        /// </summary>
        /// <returns>System.String.</returns>
        public static string ShortStr()
        {
            return Convert(GenerateLong());
        }

        /// <summary>
        /// 唯一订单号生成
        /// </summary>
        /// <returns></returns>
        public static string GenerateOrderNumber()
        {
            string strDateTimeNumber = DateTime.Now.ToString("yyyyMMddHHmmssffff");
            string strRandomResult = NextRandom(1000, 1).ToString("0000");

            return strDateTimeNumber + strRandomResult;
        }

        #region private

        /// <summary>
        /// 参考：msdn上的RNGCryptoServiceProvider例子
        /// </summary>
        /// <param name="numSeeds"></param>
        /// <param name="length"></param>
        /// <returns></returns>
        private static int NextRandom(int numSeeds, int length)
        {
            // Create a byte array to hold the random value.
            byte[] randomNumber = new byte[length];
            // Create a new instance of the RNGCryptoServiceProvider.
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            // Fill the array with a random value.
            rng.GetBytes(randomNumber);
            // Convert the byte to an uint value to make the modulus operation easier.
            uint randomResult = 0x0;
            for (int i = 0; i < length; i++)
            {
                randomResult |= ((uint) randomNumber[i] << ((length - 1 - i)*8));
            }

            return (int) (randomResult%numSeeds) + 1;
        }



        static string Seq = "s9LFkgy5RovixI1aOf8UhdY3r4DMplQZJXPqebE0WSjBn7wVzmN2Gc6THCAKut";

        /// <summary>
        /// 10进制转换为62进制
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>

        private static string Convert(long id)
        {
            if (id < 62)
            {
                return Seq[(int) id].ToString();
            }
            int y = (int) (id%62);
            long x = (long) (id/62);

            return Convert(x) + Seq[y];
        }

        #endregion


     
    }
}