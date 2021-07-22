// <copyright file="ImgHelper.cs" company="openauth.net.cn">
// Copyright (c) 2019 openauth.net.cn. All rights reserved.
// </copyright>
// <author>www.cnblogs.com/yubaolee</author>
// <summary>生成缩略图</summary>

using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Processing;

namespace Infrastructure.Helpers
{
    public class ImgHelper
    {
        /// <summary>
        /// 根据已有图片生成缩略图
        /// <para>用法：MakeThumbnail(path, tpath, 120, 90, "H");</para>
        /// </summary>
        /// <param name="originalImagePath">源图片路径</param>
        /// <param name="thumbnailPath">缩略图保存路径</param>
        /// <param name="width">缩略图的宽度</param>
        /// <param name="height">缩略图高度</param>
        /// <param name="mode">缩略模式：H:指定高度，宽度按比例处理；W：指定宽度，高度按比例处理；HW按参数指定的高度和宽度</param>
        public static void MakeThumbnail(string originalImagePath,
            string thumbnailPath,
            int width = 120, int height = 90, string mode = "H")
        {
            using (var originalImage = Image.Load(originalImagePath))
            {
                int towidth = width; //缩略图宽度
                int toheight = height;  //缩略图高度
                switch (mode)
                {
                    case "HW": //指定高宽缩放（可能变形） 
                        break;
                    case "W": //指定宽，高按比例 
                        toheight = originalImage.Height * width / originalImage.Width;
                        break;
                    case "H": //指定高，宽按比例 
                        towidth = originalImage.Width * height / originalImage.Height;
                        break;
                    default:
                        break;
                }

                originalImage.Mutate(x => x.Resize(towidth, toheight));
                originalImage.Save(thumbnailPath);
            }
        }
    }
}