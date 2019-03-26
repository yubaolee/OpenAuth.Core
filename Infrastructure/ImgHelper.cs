// <copyright file="ImgHelper.cs" company="openauth.me">
// Copyright (c) 2019 openauth.me. All rights reserved.
// </copyright>
// <author>www.cnblogs.com/yubaolee</author>
// <date>2019-03-07</date>
// <summary>生成缩略图</summary>

namespace Infrastructure
{
    public class ImgHelper
    {
        //MakeThumbnail(path, tpath, 120, 90, "H");
        public static void MakeThumbnail(string originalImagePath, 
            string thumbnailPath,
            int width=120, int height=90, string mode="H")
        {
            //Image originalImage = Image.FromFile(originalImagePath);
            //int towidth = width;
            //int toheight = height;
            //int x = 0;
            //int y = 0;
            //int ow = originalImage.Width;
            //int oh = originalImage.Height;
            //switch (mode)
            //{
            //    case "HW"://指定高宽缩放（可能变形） 
            //        break;
            //    case "W"://指定宽，高按比例 
            //        toheight = originalImage.Height * width / originalImage.Width;
            //        break;
            //    case "H"://指定高，宽按比例 
            //        towidth = originalImage.Width * height / originalImage.Height;
            //        break;
            //    case "Cut"://指定高宽裁减（不变形） 
            //        if ((double)originalImage.Width / (double)originalImage.Height > (double)towidth / (double)toheight)
            //        {
            //            oh = originalImage.Height;
            //            ow = originalImage.Height * towidth / toheight;
            //            y = 0;
            //            x = (originalImage.Width - ow) / 2;
            //        }
            //        else
            //        {
            //            ow = originalImage.Width;
            //            oh = originalImage.Width * height / towidth;
            //            x = 0;
            //            y = (originalImage.Height - oh) / 2;
            //        }
            //        break;
            //    default:
            //        break;
            //}
            //MediaTypeNames.Image bitmap = new System.Drawing.Bitmap(towidth, toheight);
            //Graphics g = System.Drawing.Graphics.FromImage(bitmap);
            //g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
            //g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            //g.Clear(Color.Transparent);
            //g.DrawImage(originalImage, new Rectangle(0, 0, towidth, toheight),
            //    new Rectangle(x, y, ow, oh),
            //    GraphicsUnit.Pixel);
            //try
            //{
            //    bitmap.Save(thumbnailPath, System.Drawing.Imaging.ImageFormat.Png);
            //}
            //catch (System.Exception e)
            //{
            //    throw e;
            //}
            //finally
            //{
            //    originalImage.Dispose();
            //    bitmap.Dispose();
            //    g.Dispose();
            //}
        }
    }
}
