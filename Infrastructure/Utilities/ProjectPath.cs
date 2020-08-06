using System.IO;
using System.Linq;
using Infrastructure.Extensions;

namespace Infrastructure.Utilities
{
    public class ProjectPath
    {
        /// <summary>
        /// 获取web父目录所在位置
        /// </summary>
        /// <returns></returns>
        public static DirectoryInfo GetProjectDirectoryInfo()
        {
            return GetProjectDirectoryInfo(new DirectoryInfo("".MapPath()), 1);
        }
        /// <summary>
        /// 获取指定结尾的项目名称 
        /// </summary>
        /// <param name="lastIndexOfName"></param>
        /// <returns></returns>
        public static string GetLastIndexOfDirectoryName(string lastIndexOfName)
        {
            string projectName = GetProjectDirectoryInfo()?.GetDirectories()
                     .Where(c => c.Name.LastIndexOf(lastIndexOfName) != -1).Select(x => x.Name).FirstOrDefault();
            if (string.IsNullOrEmpty(projectName))
            {
                projectName = new DirectoryInfo("".MapPath()).GetFiles().Where(x => x.Name.LastIndexOf(lastIndexOfName + ".dll") != -1).FirstOrDefault().Name;
                if (!string.IsNullOrEmpty(projectName))
                {
                    projectName = projectName.Replace(".dll", "");
                }
            }
            return projectName;
        }
        /// <summary>
        /// 获取项目所在路径
        /// </summary>
        /// <param name="directoryInfo"></param>
        /// <returns></returns>
        private static DirectoryInfo GetProjectDirectoryInfo(DirectoryInfo directoryInfo, int findCount)
        {
            if (directoryInfo == null)
            {
                return null;
            }
            if (directoryInfo.Exists
                && directoryInfo.GetDirectories().Where(x => x.Name.LastIndexOf(".Mvc") != -1).FirstOrDefault() != null)
            {
                return directoryInfo;
            }
            if (findCount < 7)
            {
                findCount++;
                DirectoryInfo dir = GetProjectDirectoryInfo(directoryInfo.Parent, findCount);
                if (dir != null)
                {
                    return dir;
                }
            }
            return null;
        }
    }
}
